//
//  Control.swift
//  ScriptView
//
//  Created by Evren Yortuçboylu on 14/04/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import UIKit

protocol Control {
    var rect: Rect {get set}
    var children: [Control] {get set}
    
    // func setState(newState: [String: AnyObject]) -> Void
}