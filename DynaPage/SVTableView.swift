//
//  SVTableView.swift
//  ScriptView
//
//  Created by Evren Yortuçboylu on 30/04/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import UIKit
import JavaScriptCore

@objc protocol SVTableViewExports: JSExport {
    var dataList: [String]? {get set}
    
    static func create(basicTableConfig: JSValue) -> SVBasicTableViewController
}


class SVTableView: NSObject, SVTableViewExports {

    var dataList: [String]?
    
    static func create(basicTableConfig: JSValue) -> SVBasicTableViewController {
        let dataSource = basicTableConfig.valueForProperty("items").toArray() as! [String]
        
        print("table create \(dataSource)")
        
        let sb = UIStoryboard(name: "Main", bundle:nil)
        let tableViewController = sb.instantiateViewControllerWithIdentifier("SVBasicTableView") as! SVBasicTableViewController
        tableViewController.dataList = dataSource
        
        return tableViewController
    }
}


