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
    var x: Int { get set }
    var y: Int { get set }
    var width: Int { get set }
    var height: Int { get set }
    
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
    
    dynamic var x:Int = 50
    dynamic var y:Int = 100
    dynamic var width:Int = 100
    dynamic var height:Int = 30
    
    // MARK: Private Properties
    static var containerView: UIView?
    private weak var button: UIButton!
    private var callbackTapped: JSManagedValue?
    
    init(buttonConfig: JSValue, view: UIView){
        super.init()
        
        let title = buttonConfig.valueForProperty("title").toString()
        let x = CGFloat((buttonConfig.valueForProperty("x")?.toDouble())!)
        let y = CGFloat((buttonConfig.valueForProperty("y")?.toDouble())!)
        let w = CGFloat((buttonConfig.valueForProperty("width")?.toDouble())!)
        let h = CGFloat((buttonConfig.valueForProperty("height")?.toDouble())!)
        
        let click = buttonConfig.valueForProperty("click")
        
        button = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(x, y, w, h)
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