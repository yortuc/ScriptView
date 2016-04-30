//
//  ViewController.swift
//  DynaPage
//
//  Created by Evren Yortuçboylu on 07/04/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var scriptView: ScriptView!
    
    @IBAction func reload(sender: AnyObject) {
        self.scriptView.reload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scriptView = ScriptView(view: self.view, scriptName: "githubExplorer")
    }
}