//
//  NSString+Extension.swift
//  Floral
//
//  Created by 文刂Rn on 2016/10/3.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit

extension NSString {
    
    /**
     计算UILabel的宽度
     
     - parameter labelText:  UILabel.text
     - parameter labelWidth: UILabel的宽度
     - parameter labelFont:  UILabel的font
     
     - returns: 计算UILabel的宽度
     */
    class func stringCalculateLabelWidth(labelText : String, labelHeight: CGFloat, labelFont: UIFont) -> CGFloat {
        
        let str = labelText as NSString
        
        let size : CGSize = str.boundingRectWithSize(CGSizeMake(CGFloat.max, labelHeight), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: labelFont], context: nil).size
        
        return size.width
        
    }
    
    /**
     计算UILabel的高度
     
     - parameter labelText:  UILabel.text
     - parameter labelWidth: UILabel的宽度
     - parameter labelFont:  UILabel的font
     
     - returns: 计算UILabel的高度
     */
    class func stringCalculateLabelHeight(labelText : String, labelWidth: CGFloat, labelFont: UIFont) -> CGFloat {
        
        let str = labelText as NSString
        
        let size : CGSize = str.boundingRectWithSize(CGSizeMake(labelWidth, CGFloat.max), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: labelFont], context: nil).size
        
        return size.height
        
    }
    
}
