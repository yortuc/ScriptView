//
//  Style.swift
//  ScriptView
//
//  Created by Evren Yortuçboylu on 30/04/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

/*
import UIKit
import JavaScriptCore

@objc protocol StyleExports: JSExport {
    
    var borderWidth: CGFloat? {get set}
    var borderColor: String? {get set}
    var backgroundColor: String? {get set}
    var cornerRadius: CGColor? {get set}
    
    static func create(rectConfig: JSValue) -> Style
}

class Style: NSObject, StyleExports {
    
    dynamic var borderWidth: CGFloat
    dynamic var borderColor: String
    dynamic var backgroundColor: String
    dynamic var cornerRadius: CGColor

    
    var cgRect: CGRect {
        return CGRectMake(x, y, width, height)
    }
    
    init(rectConfig: JSValue) {
        x = CGFloat((rectConfig.valueForProperty("x")?.toDouble())!)
        y = CGFloat((rectConfig.valueForProperty("y")?.toDouble())!)
        width = CGFloat((rectConfig.valueForProperty("width")?.toDouble())!)
        height = CGFloat((rectConfig.valueForProperty("height")?.toDouble())!)
    }
    
    init(_ x: Double, _ y: Double, _ width: Double, _ height: Double) {
        self.x = CGFloat(x)
        self.y = CGFloat(y)
        self.width = CGFloat(width)
        self.height = CGFloat(height)
    }
    
    init(cgRect: CGRect) {
        self.x = cgRect.origin.x
        self.y = cgRect.origin.y
        self.width = cgRect.size.width
        self.height = cgRect.size.height
    }
    
    // MARK: Class Methods
    static func create(rectConfig: JSValue) -> Rect {
        return Rect(rectConfig: rectConfig)
    }

    
}*/