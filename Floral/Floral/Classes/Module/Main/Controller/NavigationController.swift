//
//  NavigationController.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fd_fullscreenPopGestureRecognizer.isEnabled = true
        
        // 导航栏背景和文字设置
        let naviBar: UINavigationBar = UINavigationBar.appearance()
        naviBar.tintColor = UIColor.black
        naviBar.backgroundColor = .white
        
        view.backgroundColor = .white
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if children.count >= 1 {
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "login_back"), style: .plain, target: self, action: #selector(backBtnDidClick))
            // 隐藏要push的控制器的tabbar
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
}

// MARK: - 返回点击事件
extension NavigationController {
    
    @objc private func backBtnDidClick() {
        popViewController(animated: true)
    }
}
