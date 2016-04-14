//
//  Sw.swift
//  ScriptView
//
//  Created by Evren Yortuçboylu on 14/04/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import UIKit
import JavaScriptCore

@objc protocol SwExports: JSExport {
    static func render(component: JSValue)
}

class Sw: NSObject, SwExports {
    static func render(component: JSValue) {
        
        /*
         
         contols-to-render meta data sent from js
         
         Sw.render(myWholeApp);
         
         myWholeApp = { 
            type: "view", 
            rect: Rect.create(0,0,500,500), 
            style: { backgroundColor: "#efefef" },
            props: { initialCount : 5 },            // will be passed to control.props
            children: [
            
                {type: "label",     rect: Rect.create(0,0,500,40),  props: {text: "Login"} },
                {type: "textbox",   rect: Rect.create(0,60,300,30), props: {placeholder: "Username"} },
                {type: "button",    rect: Rect.create(0,80,200,30), props: {text: "Log me in", onClick: function(){} } },
         
            ]}
         
         
         
        */
        
        
        
    }
    
    static func createComponent(type: ControlType) -> Control {
        
    }
}
