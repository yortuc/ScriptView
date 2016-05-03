//
//  SVBasicViewController.swift
//  ScriptView
//
//  Created by Evren Yortuçboylu on 03/05/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import UIKit

class SVBasicViewController: UIViewController {

    var rootChildView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // embed child views
        if let rootView = self.rootChildView {
            self.view.addSubview(rootView)
            rootView.didMoveToSuperview()
        }
    }
}
