//
//  Post.swift
//  Facebook
//
//  Created by Mihail Șalari on 6/14/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit

class Post: SafeJsonObject {
    
    // MARK: - Properties
    
    var name: String?
    var profileImageName: String?
    var statusText: String?
    var statusImageName: String?
    var numLikes: NSNumber?
    var numComments: NSNumber?
    
    var location: Location?
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "location" {
            location = Location()
            location?.setValuesForKeysWithDictionary(value as! [String: AnyObject])
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
}


