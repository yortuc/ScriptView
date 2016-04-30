//
//  RootView.swift
//  ScriptView
//
//  Created by Evren Yortuçboylu on 14/04/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import UIKit
import JavaScriptCore

@objc protocol RootViewExports: JSExport {
    static func getRect ()-> Rect
}

class RootView: NSObject, RootViewExports {
    
    static var rect: Rect?
    
    static func getRect() -> Rect {
        return rect!
    }
}