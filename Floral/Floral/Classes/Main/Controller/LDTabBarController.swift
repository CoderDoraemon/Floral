//
//  LDTabBarController.swift
//  Floral
//
//  Created by 文刂Rn on 16/9/7.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit

class LDTabBarController: UITabBarController {

    override func viewDidLoad() {
        setup()
    }
    
    private func setup() {
        
        tabBar.tintColor = UIColor.blackColor()
        
        addChildViewController(LDSubjectController(), title: "专题")
        addChildViewController(LDCommunityController(), title: "社区")
        addChildViewController(LDStoreController(), title: "商城")
        addChildViewController(LDMeController(), title: "我的")
        
    
    }
    
    private func addChildViewController(childController: UIViewController, title: String) {
        
        let nav = LDNavigationController(rootViewController: childController)
        
        addChildViewController(nav)
        
        childController.tabBarItem.title = title
        childController.tabBarItem.image = UIImage(named: "tb_\(childViewControllers.count - 1)")
        childController.tabBarItem.selectedImage = UIImage.imageToOriginalImage("tb_\(childViewControllers.count - 1)" + "_s")
        
        
        
    }
    
}
