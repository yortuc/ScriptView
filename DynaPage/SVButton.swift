//
//  Button.swift
//  ScriptView
//
//  Created by Evren Yortuçboylu on 08/04/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//


import UIKit
import JavaScriptCore

@objc protocol SVButtonExports: JSExport, UITextFieldDelegate {
    var title: String { get set }
    var rect: Rect? {get set }
    
    static func create(buttonBoxConfig: JSValue) -> SVButton
}

class SVButton: NSObject, SVButtonExports {
    
    // MARK: Interface Properties
    dynamic var title: String = "Button" {
        didSet {
            print("button title changed")
            self.button.setTitle(title, forState: .Normal)
        }
    }
    
    dynamic var rect: Rect?
    
    // MARK: Private Properties
    static var containerView: UIView?
    private weak var button: UIButton!
    private var callbackTapped: JSManagedValue?
    
    init(buttonConfig: JSValue, view: UIView){
        super.init()
        
        let title = buttonConfig.valueForProperty("title").toString()
        rect = Rect(rectConfig: buttonConfig.valueForProperty("rect"))
        
        let click = buttonConfig.valueForProperty("click")
        
        button = UIButton(type: UIButtonType.System) as UIButton
        button.frame = rect!.cgRect
        button.setTitle(title, forState: UIControlState.Normal)
        
        callbackTapped = JSManagedValue(value: click, andOwner: self)
        button.addTarget(self, action: #selector(SVButton.buttonTapped(_:)), forControlEvents: .TouchUpInside)
        
        view.addSubview(button)
    }
    
    deinit {
        print("button will deinit")
        self.button.removeFromSuperview()
        self.button = nil
    }
    
    // MARK: Event Handlers
    func buttonTapped(sender: AnyObject?) {
        callbackTapped?.value.callWithArguments(nil)
    }
    
    // MARK: Class Methods
    static func create(buttonConfig: JSValue) -> SVButton {
        return SVButton(buttonConfig: buttonConfig, view: containerView!)
    }
}