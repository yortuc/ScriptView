//
//  Rect.swift
//  ScriptView
//
//  Created by Evren Yortuçboylu on 14/04/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import UIKit
import JavaScriptCore

@objc protocol RectExports: JSExport {
    var x: CGFloat { get set }
    var y: CGFloat { get set }
    var width: CGFloat { get set }
    var height: CGFloat { get set }
    
    static func create(rectConfig: JSValue) -> Rect
}

class Rect: NSObject, RectExports {
    dynamic var x: CGFloat
    dynamic var y: CGFloat
    dynamic var width: CGFloat
    dynamic var height: CGFloat
    
    var cgRect: CGRect {
        return CGRectMake(x, y, width, height)
    }
    
    init(rectConfig: JSValue) {
        x = CGFloat((rectConfig.valueForProperty("x")?.toDouble())!)
        y = CGFloat((rectConfig.valueForProperty("y")?.toDouble())!)
        width = CGFloat((rectConfig.valueForProperty("width")?.toDouble())!)
        height = CGFloat((rectConfig.valueForProperty("height")?.toDouble())!)
    }
    
    // MARK: Class Methods
    static func create(rectConfig: JSValue) -> Rect {
        return Rect(rectConfig: rectConfig)
    }
}