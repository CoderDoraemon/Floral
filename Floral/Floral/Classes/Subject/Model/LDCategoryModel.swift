//
//  LDCategoryModel.swift
//  Floral
//
//  Created by 文刂Rn on 16/9/10.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit

class LDCategoryModel: NSObject {

    var createDate : String?
    var enName : String?
    var img : String?
    var name : String?
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
