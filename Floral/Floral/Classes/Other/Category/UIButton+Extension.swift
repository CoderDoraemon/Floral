//
//  UIButton+Extension.swift
//  Floral
//
//  Created by 文刂Rn on 16/9/13.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    convenience init(imageName: String?, target: AnyObject?, selector: Selector?, font: UIFont?, titleColor: UIColor?, title: String?) {
        self.init()
        
        if (imageName != nil) {
            setImage(UIImage(named: imageName!), forState: .Normal)
        }
        
        if (target != nil && selector != nil) {
            addTarget(target, action: selector!, forControlEvents: .TouchUpInside)
        }
        
        setTitle(title, forState: .Normal)
        titleLabel?.font = font
        
        setTitleColor(titleColor, forState: .Normal)
        
    }
    
}