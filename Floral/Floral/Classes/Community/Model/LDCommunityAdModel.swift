//
//  LDCommunityAdModel.swift
//  Floral
//
//  Created by 文刂Rn on 2016/10/10.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit

class LDCommunityAdModel: NSObject {
    
    var url: String?
    var title: String?
    var AId: String?
    var imageUrl: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

}
