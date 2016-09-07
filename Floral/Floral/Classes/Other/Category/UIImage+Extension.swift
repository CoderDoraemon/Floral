//
//  UIImage+Extension.swift
//  Floral
//
//  Created by 文刂Rn on 16/6/19.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    class func imageToOriginalImage(imageString : NSString) -> UIImage? {
        
        let image = UIImage(named: imageString as String)
        return image?.imageWithRenderingMode(.AlwaysOriginal)
        
    }
    
    
}
