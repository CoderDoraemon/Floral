//
//  JZUtilTool.swift
//  JZOA
//
//  Created by Apple on 2018/11/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit
import Kingfisher

class UtilTool: NSObject {
    
    static let shared = UtilTool()
    
    /// 获取唯一标识
    ///
    /// - Parameter cellClass: 类名
    /// - Returns: 返回唯一字符串标识
    class func cellIdentifier(_ cellClass: UIView.Type) -> String {
        return "\(String(describing: cellClass))" + "Identifier"
    }
}


extension UtilTool {
    
    /* 递归找最上面的viewController */
    static func topViewController() -> UIViewController? {
        
        return self.topViewControllerWithRootViewController(viewController: self.getCurrentWindow()?.rootViewController)
    }
    
    
}

fileprivate extension UtilTool {
    
    static func topViewControllerWithRootViewController(viewController :UIViewController?) -> UIViewController? {
        
        if viewController == nil {
            
            return nil
        }
        
        if viewController?.presentedViewController != nil {
            
            return self.topViewControllerWithRootViewController(viewController: viewController?.presentedViewController!)
        }
        else if viewController?.isKind(of: UITabBarController.self) == true {
            
            return self.topViewControllerWithRootViewController(viewController: (viewController as! UITabBarController).selectedViewController)
        }
        else if viewController?.isKind(of: UINavigationController.self) == true {
            
            return self.topViewControllerWithRootViewController(viewController: (viewController as! UINavigationController).visibleViewController)
        }
        else {
            
            return viewController
        }
    }
    
    // 找到当前显示的window
    static func getCurrentWindow() -> UIWindow? {
        
        // 找到当前显示的UIWindow
        var window: UIWindow? = UIApplication.shared.keyWindow
        /**
         window有一个属性：windowLevel
         当 windowLevel == UIWindowLevelNormal 的时候，表示这个window是当前屏幕正在显示的window
         */
        if window?.windowLevel != UIWindow.Level.normal {
            
            for tempWindow in UIApplication.shared.windows {
                
                if tempWindow.windowLevel == UIWindow.Level.normal {
                    
                    window = tempWindow
                    break
                }
            }
        }
        
        return window
    }
    
}

