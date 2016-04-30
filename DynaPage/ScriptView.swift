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
    private var require: @convention(block) String -> JSValue = {_ in return JSValue()}
    private var log: @convention(block) String -> Void = { _ in }
    
    init(view: UIView){
        self.registerPublicFuncs()
        self.registerControls(view)
        require("main")
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
        
        RootView.rect = Rect(cgRect: view.frame)
        context.setObject(unsafeBitCast(RootView.self, AnyObject.self), forKeyedSubscript: "RootView")
    }
}