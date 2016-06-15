//
//  RequestTabeViewCell.swift
//  Facebook
//
//  Created by Mihail Șalari on 6/14/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit

class RequestTabeViewCell: BaseTableViewCell {
    
    
    let nameLabel = UILabel.createLabelWithCustomFont(labelName: "Sample Label",
                                                      numebrOfLines: 0,
                                                      textColor: UIColor.blackColor(),
                                                      labelFont: UIFont.boldSystemFontOfSize(12))
    
    let requestImageView = UIImageView.createImageView("requests_icon")
    
    let confirmButton = UIButton.setSimpleButton(setTitle: "Confirm",
                                                 titleColor: UIColor.whiteColor(),
                                                 setFont: UIFont.boldSystemFontOfSize(10),
                                                 cornerRadius: 2,
                                                 backgroundColor: UIColor.requestButtonFeatureColor())
    
    let deleteButton: UIButton = {
        
        let button = UIButton.setSimpleButton(setTitle: "Delete",
                                                titleColor: UIColor(white: 0.3, alpha: 1),
                                                setFont: UIFont.boldSystemFontOfSize(10),
                                                cornerRadius: 2,
                                                backgroundColor: UIColor.clearColor())
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(white: 0.7, alpha: 1).CGColor
        
        return button
    }()
    
    
    override func setupViews() {
        
        addSubview(requestImageView)
        addSubview(nameLabel)
        addSubview(confirmButton)
        addSubview(deleteButton)
        
        addConstraintsWithFormat("H:|-16-[v0(52)]-8-[v1]|", views: requestImageView, nameLabel)
        
        addConstraintsWithFormat("V:|-4-[v0]-4-|", views: requestImageView)
        
        addConstraintsWithFormat("V:|-8-[v0]-8-[v1(24)]-8-|", views: nameLabel, confirmButton)
        
        addConstraintsWithFormat("H:|-76-[v0(80)]-8-[v1(80)]", views: confirmButton, deleteButton)
        
        addConstraintsWithFormat("V:[v0(24)]-8-|", views: deleteButton)
    }
    
    
    
}
