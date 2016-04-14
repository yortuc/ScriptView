//
//  ControlTypes.swift
//  ScriptView
//
//  Created by Evren Yortuçboylu on 14/04/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import UIKit
import JavaScriptCore

enum ControlType {
    case View(rect: Rect, children: [Control])
    case Textbox
    case Label
    case Button
}


