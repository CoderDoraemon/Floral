//
//  LDAuthorModel.swift
//  Floral
//
//  Created by 文刂Rn on 16/9/10.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit

class LDAuthorModel: NSObject {
    
    var auth : String?
    var content : String?
    var headImg : String?
    var identity : String?
    var integral : NSInteger = 0
    var userName : String?
    

    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
}
