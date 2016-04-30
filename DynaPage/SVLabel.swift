//
//  Button.swift
//  ScriptView
//
//  Created by Evren Yortuçboylu on 08/04/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//


import UIKit
import JavaScriptCore

@objc protocol SVLabelExports: JSExport, UITextFieldDelegate {
    var text: String { get set }
    var rect: Rect? { get set }
    
    static func create(buttonBoxConfig: JSValue) -> SVLabel
}

class SVLabel: NSObject, SVLabelExports, SVComponent {
    
    // MARK: Interface Properties
    dynamic var text: String = "Button" {
        didSet {
            print("label text changed")
            self.label.text = text
        }
    }
    
    dynamic var rect: Rect?
    
    // MARK: Private Properties
    static var containerView: UIView?
    private var label: UILabel!
    
    var localView: UIView? {
        return self.label
    }
    
    init(labelConfig: JSValue, view: UIView){
        super.init()
        
        let text = labelConfig.valueForProperty("text").toString()
        let rect = Rect(rectConfig: labelConfig.valueForProperty("rect"))
        
        label = UILabel(frame: rect.cgRect)
        label.center = CGPointMake(rect.x + rect.width/2, rect.y + rect.height/2)
        label.textAlignment = NSTextAlignment.Center
        label.text = text

        view.addSubview(label)
    }
    
    deinit {
        print("label will deinit")
        
        self.label.removeFromSuperview()
        self.label = nil
    }
    
    // MARK: Class Methods
    static func create(labelConfig: JSValue) -> SVLabel {
        return SVLabel(labelConfig: labelConfig, view: containerView!)
    }
}