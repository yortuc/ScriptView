//
//  TextBox.swift
//  ScriptView
//
//  Created by Evren Yortuçboylu on 08/04/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import UIKit
import JavaScriptCore

@objc protocol SVTextBoxExports: JSExport, UITextFieldDelegate {
    var placeholder: String { get set }
    var x: Int { get set }
    var y: Int { get set }
    var width: Int { get set }
    var height: Int { get set }
    
    var text: String? {get set }
    
    static func create(textBoxConfig: JSValue) -> SVTextBox
}

class SVTextBox: NSObject, SVTextBoxExports {
    
    // MARK: Interface Properties
    dynamic var placeholder: String = "Textbox" {
        didSet {
            print("textbox placeholder changed")
            self.textField.placeholder = placeholder
        }
    }
    
    dynamic var x:Int = 50
    dynamic var y:Int = 100
    dynamic var width:Int = 100
    dynamic var height:Int = 30
    dynamic var text:String? {
        get {
            return self.textField.text
        }
        set {
            self.textField.text = newValue
        }
    }
    
    // MARK: Private Properties
    static var containerView: UIView?
    private weak var textField: UITextField!
    private var callbackEdited: JSManagedValue?
    
    init(textBoxConfig: JSValue, view: UIView){
        super.init()
        
        let placeholder = textBoxConfig.valueForProperty("placeholder").toString()
        let x = CGFloat((textBoxConfig.valueForProperty("x")?.toDouble())!)
        let y = CGFloat((textBoxConfig.valueForProperty("y")?.toDouble())!)
        let w = CGFloat((textBoxConfig.valueForProperty("width")?.toDouble())!)
        let h = CGFloat((textBoxConfig.valueForProperty("height")?.toDouble())!)
        
        textField = UITextField(frame: CGRectMake(x, y, w, h))
        textField.placeholder = placeholder
        textField.font = UIFont.systemFontOfSize(15)
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.autocorrectionType = UITextAutocorrectionType.No
        textField.keyboardType = UIKeyboardType.Default
        textField.returnKeyType = UIReturnKeyType.Done
        textField.clearButtonMode = UITextFieldViewMode.WhileEditing;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        textField.delegate = self
        
        let editedCallback = textBoxConfig.valueForProperty("edited")
        self.callbackEdited = JSManagedValue(value: editedCallback, andOwner: self)
        
        view.addSubview(textField)
    }
    
    deinit {
        print("textbox will deinit")
        self.textField.removeFromSuperview()
        self.textField = nil
    }
    
    // MARK: Event Handlers
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.callbackEdited?.value.callWithArguments([textField.text!])
        return true;
    }
    
    // MARK: Class Methods
    static func create(textBoxConfig: JSValue) -> SVTextBox {
        return SVTextBox(textBoxConfig: textBoxConfig, view: containerView!)
    }
}