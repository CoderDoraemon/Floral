//
//  LDCommunityModel.swift
//  Floral
//
//  Created by 文刂Rn on 2016/10/10.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit

class LDCommunityModel: NSObject {
    
    var attachment: String?
    var attachmentSnap: String?
    var content: String?
    var sharePageUrl: String?
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    

}
