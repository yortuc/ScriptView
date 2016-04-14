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
    var x: Int { get set }
    var y: Int { get set }
    var width: Int { get set }
    var height: Int { get set }
}

class Rect: NSObject, RectExports {
    dynamic var x: Int = 0
    dynamic var y: Int = 0
    dynamic var width: Int = 100
    dynamic var height: Int = 40
}