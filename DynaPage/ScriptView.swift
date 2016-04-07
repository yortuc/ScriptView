//
//  ScriptView.swift
//  DynaPage
//
//  Created by Evren Yortuçboylu on 07/04/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import UIKit
import JavaScriptCore

class ScriptView: NSObject, UITextFieldDelegate {
    
    var view: UIView?
    
    let context = JSContext()
    
    var require: @convention(block) String -> JSValue = {_ in return JSValue()}
    
    var log: @convention(block) String -> Void = { _ in }
    
    var createButton: @convention(block) JSValue -> JSValue = {_ in return JSValue() }
    
    var createTextBox: @convention(block) JSValue -> Void = {_ in}
    
    var createLabel: @convention(block) JSValue -> Void = {_ in}
    
    var buttonCallbacks = [UIButton: JSValue]()
    var textFieldCallbacks = [UITextField: JSValue]()
    
    init(view: UIView){
        super.init()
        self.view = view
        
        require = { moduleName in
            
            self.context.evaluateScript("var module = {};")
            self.context.evaluateScript("module.exports = {};")
            self.context.evaluateScript("var exports = module.exports;")
            
            let path = NSBundle.mainBundle().pathForResource(moduleName, ofType: "js")
            let contentData = NSFileManager.defaultManager().contentsAtPath(path!)
            let content = NSString(data: contentData!, encoding: NSUTF8StringEncoding) as? String
            let jsv = self.context.evaluateScript(content)
            
            let moduleObject = self.context.objectForKeyedSubscript("module")
            let moduleExports = moduleObject.valueForProperty("exports")
            
            return moduleExports
        }
        
        log = { text in
            print("\(text)")
        }
        
        createButton =  { buttonConfig in
            
            let title = buttonConfig.valueForProperty("title").toString()
            let x = CGFloat((buttonConfig.valueForProperty("x")?.toDouble())!)
            let y = CGFloat((buttonConfig.valueForProperty("y")?.toDouble())!)
            let w = CGFloat((buttonConfig.valueForProperty("width")?.toDouble())!)
            let h = CGFloat((buttonConfig.valueForProperty("height")?.toDouble())!)
            
            let click = buttonConfig.valueForProperty("click")
            
            let button = UIButton(type: UIButtonType.System) as UIButton
            button.frame = CGRectMake(x, y, w, h)
            button.setTitle(title, forState: UIControlState.Normal)
            
            self.buttonCallbacks[button] = click
            button.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
            
            self.view!.addSubview(button)
            
            return buttonConfig
        }
        
        createTextBox = { textBoxConfig in
            let placeholder = textBoxConfig.valueForProperty("placeholder").toString()
            let x = CGFloat((textBoxConfig.valueForProperty("x")?.toDouble())!)
            let y = CGFloat((textBoxConfig.valueForProperty("y")?.toDouble())!)
            let w = CGFloat((textBoxConfig.valueForProperty("width")?.toDouble())!)
            let h = CGFloat((textBoxConfig.valueForProperty("height")?.toDouble())!)
            let editedCallback = textBoxConfig.valueForProperty("edited")


            let textField = UITextField(frame: CGRectMake(x, y, w, h))
            textField.placeholder = placeholder
            textField.font = UIFont.systemFontOfSize(15)
            textField.borderStyle = UITextBorderStyle.RoundedRect
            textField.autocorrectionType = UITextAutocorrectionType.No
            textField.keyboardType = UIKeyboardType.Default
            textField.returnKeyType = UIReturnKeyType.Done
            textField.clearButtonMode = UITextFieldViewMode.WhileEditing;
            textField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
            textField.delegate = self
            
            self.textFieldCallbacks[textField] = editedCallback
            
            self.view!.addSubview(textField)
        }
        
        createLabel = { labelConfig in
            let text = labelConfig.valueForProperty("text").toString()
            let x = CGFloat((labelConfig.valueForProperty("x")?.toDouble())!)
            let y = CGFloat((labelConfig.valueForProperty("y")?.toDouble())!)
            let w = CGFloat((labelConfig.valueForProperty("width")?.toDouble())!)
            let h = CGFloat((labelConfig.valueForProperty("height")?.toDouble())!)

            
            let label = UILabel(frame: CGRectMake(x, y, w, h))
            label.center = CGPointMake(x + w/2, y + h/2)
            label.textAlignment = NSTextAlignment.Center
            label.text = text
            
            self.view!.addSubview(label)
        }
        
        context.setObject(unsafeBitCast(require, AnyObject.self), forKeyedSubscript: "require")
        context.setObject(unsafeBitCast(log, AnyObject.self), forKeyedSubscript: "log")
        context.setObject(unsafeBitCast(createButton, AnyObject.self), forKeyedSubscript: "createButton")
        context.setObject(unsafeBitCast(createTextBox, AnyObject.self), forKeyedSubscript: "createTextBox")
        context.setObject(unsafeBitCast(createLabel, AnyObject.self), forKeyedSubscript: "createLabel")

        require("main")
    }
    
    func buttonTapped(sender: AnyObject?) {
        buttonCallbacks[sender as! UIButton]?.callWithArguments(nil)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        textFieldCallbacks[textField]?.callWithArguments([textField.text!])
        return true;
    }
}