//
//  ScriptView.swift
//  DynaPage
//
//  Created by Evren Yortuçboylu on 07/04/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import UIKit
import JavaScriptCore

class ScriptView {
    
    private var context = JSContext()

    // MARK: Public Functions
    private var download: @convention(block) String -> String = {_ in return "" }
    private var require: @convention(block) String -> JSValue = {_ in return JSValue()}
    private var log: @convention(block) String -> Void = { _ in }
    private var present: @convention(block) UIViewController -> Void = { _ in }
    
    init(view: UIView, scriptName: String){
        self.registerPublicFuncs()
        self.registerControls(view)
        require(scriptName)
    }
    
    func reload(){
        print("reloading")
        require("main")
    }
    
    private func registerPublicFuncs(){
        context.exceptionHandler = { context, exception in
            print("JS Error: \(exception)")
        }
        
        require = { moduleName in
            
            self.context.evaluateScript("var module = {};")
            self.context.evaluateScript("module.exports = {};")
            self.context.evaluateScript("var exports = module.exports;")
            
            let path = NSBundle.mainBundle().pathForResource(moduleName, ofType: "js")
            let contentData = NSFileManager.defaultManager().contentsAtPath(path!)
            let content = NSString(data: contentData!, encoding: NSUTF8StringEncoding) as? String
            let _ = self.context.evaluateScript(content)
            
            let moduleObject = self.context.objectForKeyedSubscript("module")
            let moduleExports = moduleObject.valueForProperty("exports")
            
            return moduleExports
        }
        
        log = { text in
            print("\(text)")
        }
        
        download = { url in
            print("downloading \(url)")
            if let data = NSData(contentsOfURL: NSURL(string: url)!) {
                let datastring = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
                return datastring
            }
            else{
                print("data cannot be downloaded")
                return "no-data"
            }
        }
        
        present = { viewController in
            if var topController = UIApplication.sharedApplication().keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                
                let navController = topController as! UINavigationController
                
                print("presenting viewController on \(topController)")
                navController.pushViewController(viewController, animated: true)
                // topController.presentViewController(viewController, animated: true, completion: nil)
            }
        }
        
        context.setObject(unsafeBitCast(present, AnyObject.self), forKeyedSubscript: "present")
        context.setObject(unsafeBitCast(download, AnyObject.self), forKeyedSubscript: "download")
        context.setObject(unsafeBitCast(require, AnyObject.self), forKeyedSubscript: "require")
        context.setObject(unsafeBitCast(log, AnyObject.self), forKeyedSubscript: "log")
    }
    
    private func registerControls(view: UIView) {
        SVButton.containerView = view
        SVTextBox.containerView = view
        SVLabel.containerView = view
        SVView.containerView = view
        
        // classes
        context.setObject(unsafeBitCast(SVTextBox.self, AnyObject.self), forKeyedSubscript: "TextBox")
        context.setObject(unsafeBitCast(SVLabel.self, AnyObject.self), forKeyedSubscript: "Label")
        context.setObject(unsafeBitCast(SVButton.self, AnyObject.self), forKeyedSubscript: "Button")
        context.setObject(unsafeBitCast(Rect.self, AnyObject.self), forKeyedSubscript: "Rect")
        
        context.setObject(unsafeBitCast(SVView.self, AnyObject.self), forKeyedSubscript: "View")
        context.setObject(unsafeBitCast(SVTableView.self, AnyObject.self), forKeyedSubscript: "TableView")
        
        RootView.rect = Rect(cgRect: view.frame)
        context.setObject(unsafeBitCast(RootView.self, AnyObject.self), forKeyedSubscript: "RootView")
    }
}