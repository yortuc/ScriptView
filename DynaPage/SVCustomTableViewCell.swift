//
//  SVCustomTableViewCell.swift
//  ScriptView
//
//  Created by Evren Yortuçboylu on 04/05/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import UIKit

class SVCustomTableViewCell: UITableViewCell {
    
    var rootChildView: UIView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let rootChild = self.rootChildView {
            self.contentView.addSubview(rootChild)
        }
    }
}