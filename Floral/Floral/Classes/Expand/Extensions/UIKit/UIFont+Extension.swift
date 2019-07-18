//
//  UIFont+Extension.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

extension UIFont {
    
    /// 系统字体大小适配
    ///
    /// - Parameter at: 6S下字号
    /// - Returns: 系统字体大小
    func fontSize(_ at: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: autoDistance(at))
    }
    
    /// 粗体适配
    ///
    /// - Parameter at: 6S下字号
    /// - Returns: 粗体字体大小
    func boldFontSize(_ at: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: autoDistance(at))
    }
}
