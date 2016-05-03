//
//  SVPage.swift
//  ScriptView
//
//  Created by Evren Yortuçboylu on 03/05/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import UIKit
import JavaScriptCore

@objc protocol SVPageViewExports: JSExport {
    var rootChildView: UIView? {get set}
    
    static func create(basicTableConfig: JSValue) -> SVBasicViewController
}


class SVPageView: NSObject, SVPageViewExports {
    
    var rootChildView: UIView?
    
    static func create(pageViewConfig: JSValue) -> SVBasicViewController {

        print("page create")
        
        let sb = UIStoryboard(name: "Main", bundle:nil)
        let viewController = sb.instantiateViewControllerWithIdentifier("SVBasicView") as! SVBasicViewController

        if let rootView = pageViewConfig.valueForProperty("rootView").toObject() as? SVView {
            viewController.rootChildView = rootView.localView
        }
        
        if let pageTitle = pageViewConfig.valueForProperty("title")?.toString() {
            viewController.title = pageTitle
        }
        
        return viewController
    }
}

