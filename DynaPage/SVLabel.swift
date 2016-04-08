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
    var x: Int { get set }
    var y: Int { get set }
    var width: Int { get set }
    var height: Int { get set }
    
    static func create(buttonBoxConfig: JSValue) -> SVLabel
}

class SVLabel: NSObject, SVLabelExports {
    
    // MARK: Interface Properties
    dynamic var text: String = "Button" {
        didSet {
            print("label text changed")
            self.label.text = text
        }
    }
    
    dynamic var x:Int = 50
    dynamic var y:Int = 100
    dynamic var width:Int = 100
    dynamic var height:Int = 30
    
    // MARK: Private Properties
    static var containerView: UIView?
    private var label: UILabel!
    
    init(labelConfig: JSValue, view: UIView){
        super.init()
        
        let text = labelConfig.valueForProperty("text").toString()
        let x = CGFloat((labelConfig.valueForProperty("x")?.toDouble())!)
        let y = CGFloat((labelConfig.valueForProperty("y")?.toDouble())!)
        let w = CGFloat((labelConfig.valueForProperty("width")?.toDouble())!)
        let h = CGFloat((labelConfig.valueForProperty("height")?.toDouble())!)
        
        label = UILabel(frame: CGRectMake(x, y, w, h))
        label.center = CGPointMake(x + w/2, y + h/2)
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