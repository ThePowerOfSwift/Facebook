//
//  SafeJSONObject.swift
//  Facebook
//
//  Created by Mihail Șalari on 6/15/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit

class SafeJsonObject: NSObject {
    
    override func setValue(value: AnyObject?, forKey key: String) {
        let selectorString = "set\(key.uppercaseString.characters.first!)\(String(key.characters.dropFirst())):"
        let selector = Selector(selectorString)
        if respondsToSelector(selector) {
            super.setValue(value, forKey: key)
        }
    }
    
}
