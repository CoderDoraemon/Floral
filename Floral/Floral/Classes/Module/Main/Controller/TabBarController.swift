//
//  TabBarController.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBar()
        seUpTabBarAttr()
        
        let communityVc = LDCommunityController.pageController()
        let materialVc = LDMaterialController.pageController()
        
        addChildVc(childVc: communityVc, imageName: "tb_0", title: "研究社")
        addChildVc(childVc: LDCollegeController(collectionViewLayout: UICollectionViewFlowLayout()), imageName: "tb_1", title: "学院")
        addChildVc(childVc: LDSharedController(), imageName: "tb_2", title: "分享会")
        addChildVc(childVc: materialVc, imageName: "tb_3", title: "素材")
        addChildVc(childVc: LDMineController(), imageName: "tb_4", title: "我的")
    }
}

// MARK: - 设置 TabBar 属性
extension TabBarController {
    
    private func setUpTabBar() {
        
        let tabBar = TabBar()
        tabBar.tintColor = UIColor.black
        setValue(tabBar, forKey: "tabBar")
    }
    
    private func seUpTabBarAttr() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .selected)
    }
}

// MARK: - 设置子控制器
extension TabBarController {
    
    private func addChildVc(childVc: UIViewController, imageName: String, title: String) {
        
        childVc.tabBarItem.image = UIImage.originImage(imageName)
        childVc.tabBarItem.selectedImage = UIImage.originImage("\(imageName)_s")
        childVc.tabBarItem.title = title
        
        let childNav = NavigationController(rootViewController: childVc)
        
        addChild(childNav)
    }
    
    
}
