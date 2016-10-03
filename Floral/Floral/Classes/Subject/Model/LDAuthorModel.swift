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
    var newAuth : NSInteger = 0 {
        
        didSet {
            switch newAuth {
            case 1:
                authImage = UIImage(named: "u_vip_yellow")
            case 2:
                authImage = UIImage(named: "personAuth")
            default:
                authImage = UIImage(named: "u_vip_blue")
            }
        }
        
    }
    
    /// 附属属性
    var authImage : UIImage?
    
    
    

    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
