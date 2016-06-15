//
//  BaseCollectionViewCell.swift
//  Facebook
//
//  Created by Mihail Șalari on 6/13/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    
    func setupViews() {}
}
