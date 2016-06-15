//
//  RequestHeaderCell.swift
//  Facebook
//
//  Created by Mihail Șalari on 6/14/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit

class RequestHeaderCell: UITableViewHeaderFooterView {
   
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    
    let nameLabel = UILabel.createLabelWithCustomFont(labelName: "Friend Requests",
                                                      numebrOfLines: 0,
                                                      textColor: UIColor(white: 0.4, alpha: 1),
                                                      labelFont: UIFont.systemFontOfSize(10))
    let bottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(229, green: 231, blue: 235, alpha: 1)
        
        return view
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addSubview(bottomBorderView)
        
        addConstraintsWithFormat("H:|-8-[v0]-8-|", views: nameLabel)
        
        addConstraintsWithFormat("V:|[v0][v1(0.7)]|", views: nameLabel, bottomBorderView)
        
        addConstraintsWithFormat("H:|[v0]|", views: bottomBorderView)
    }
}
