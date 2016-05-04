//
//  SVCustomTableView.swift
//  ScriptView
//
//  Created by Evren Yortuçboylu on 04/05/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import UIKit
import JavaScriptCore

@objc protocol SVCustomTableViewExports: JSExport {
    var dataList: [String]? {get set}
    
    static func create(customTableConfig: JSValue) -> SVCustomTableViewController
}


class SVCustomTableView: NSObject, SVCustomTableViewExports {
    
    var dataList: [String]?
    
    static func create(customTableConfig: JSValue) -> SVCustomTableViewController {
        let dataSource = customTableConfig.valueForProperty("items").toArray() as [AnyObject]
        
        print("custom table create \(dataSource)")
        
        let sb = UIStoryboard(name: "Main", bundle:nil)
        let tableViewController = sb.instantiateViewControllerWithIdentifier("SVCustomTableView") as! SVCustomTableViewController
        tableViewController.dataList = dataSource
        
        /*if let onItemSelected = basicTableConfig.valueForProperty("onItemSelected") {
            tableViewController.onItemSelected = { itemIndex in
                print("item selected")
                onItemSelected.callWithArguments([itemIndex])
            }
        }*/
        
        /*if let pageTitle = customTableConfig.valueForProperty("title")?.toString() {
            tableViewController.title = pageTitle
        }*/
        
        if let onRenderRowCallback = customTableConfig.valueForProperty("onRenderRow") {
            
            tableViewController.onRenderRow = { itemIndex in
                let renderedCellView = onRenderRowCallback.callWithArguments([itemIndex]).toObject() as! SVView
                return renderedCellView
            }
        }
        
        return tableViewController
    }
}


