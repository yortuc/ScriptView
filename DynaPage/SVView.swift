//
//  SVView.swift
//  ScriptView
//
//  Created by Evren Yortuçboylu on 30/04/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import UIKit
import JavaScriptCore
import Foundation

@objc protocol SVViewExports: JSExport {
    var rect: Rect? {get set }
    
    var backgroundColor: String? {get set}
    var borderRadius: Int {get set}
    var borderColor: String? {get set}
    
    static func create(viewConfig: JSValue) -> SVView
    func addChild(component: SVComponent)
}

@objc protocol SVComponent {
    var localView: UIView? {get}
}

class SVView: NSObject, SVViewExports, SVComponent {
    
    dynamic var rect: Rect?
    
    dynamic var backgroundColor: String?
    dynamic var borderRadius: Int = 0
    dynamic var borderColor: String?
    
    // MARK: Private Properties
    var localView: UIView?
    static var containerView: UIView?
    
    init(viewConfig: JSValue, view: UIView){
        super.init()
        
        rect = Rect(rectConfig: viewConfig.valueForProperty("rect"))
        
        print("rect view: \(rect!.cgRect.width)")
        
        let viewControl = UIView(frame: rect!.cgRect)
        
        if let backgroundColorProp = viewConfig.valueForProperty("backgroundColor") {
            viewControl.backgroundColor = hexToUIColor(backgroundColorProp.toString())
        }
        
        if let borderRadiusProp = viewConfig.valueForProperty("borderRadius") {
            viewControl.clipsToBounds = true
            viewControl.layer.cornerRadius = CGFloat(borderRadiusProp.toInt32())
        }
        
        if let borderColorProp = viewConfig.valueForProperty("borderColor") {
            viewControl.layer.borderWidth = 2
            viewControl.layer.borderColor = hexToUIColor(borderColorProp.toString()).CGColor
        }
        
        view.addSubview(viewControl)
        viewControl.didMoveToSuperview()
        
        self.localView = viewControl
    }
    
    func addChild(component: SVComponent) {
        print("add child \(component)")
        component.localView?.removeFromSuperview()
        self.localView?.addSubview(component.localView!)
    }
    
    static func create(viewConfig: JSValue) -> SVView {
        return SVView(viewConfig: viewConfig, view: containerView!)
    }
}

func hexToUIColor(hexString:String) -> UIColor {
    let hexString:NSString = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    let scanner            = NSScanner(string: hexString as String)
    
    if (hexString.hasPrefix("#")) {
        scanner.scanLocation = 1
    }
    
    var color:UInt32 = 0
    scanner.scanHexInt(&color)
    
    let mask = 0x000000FF
    let r = Int(color >> 16) & mask
    let g = Int(color >> 8) & mask
    let b = Int(color) & mask
    
    let red   = CGFloat(r) / 255.0
    let green = CGFloat(g) / 255.0
    let blue  = CGFloat(b) / 255.0

    return UIColor(red: red, green: green, blue: blue, alpha: 1)
}