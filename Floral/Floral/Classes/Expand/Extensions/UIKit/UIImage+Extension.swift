//
//  UIImage+Extension.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func originImage(_ imageName: String) -> UIImage? {
        
        guard let image: UIImage = UIImage(named: imageName) else {
                return nil
        }
        return image.withRenderingMode(.alwaysOriginal)
    }
}
