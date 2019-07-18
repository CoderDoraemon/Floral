//
//  LDCommunityController.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class LDCommunityController: PageViewController {
    
    /** 默认Vip */
    fileprivate let titleArray: [String] = ["推荐", "名师", "学习计划", "村落"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if lineView.superview == nil {
            menuView?.addSubview(lineView)
        }
    }
    
}


fileprivate extension LDCommunityController {
    
    func setup() {
        
        let rightView_width: CGFloat = 35
        
        menuItemWidth = (ScreenWidth - rightView_width) / CGFloat(titleArray.count)
        menuView?.layoutMode = .left
        scrollView?.backgroundColor = UIColor.white
        view.backgroundColor = UIColor.white
        fd_prefersNavigationBarHidden = true
        
        let searchButton = UIButton(type: .custom)
        searchButton.setImage(UIImage(named: "f_search"), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: rightView_width, height: rightView_width)
        menuView?.rightView = searchButton
        
        searchButton.rx
            .tap
            .delay(RxTimeInterval.seconds(3), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                
            }).disposed(by: rx.disposeBag)
    }
}

extension LDCommunityController {
    
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        
        return titleArray.count
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        
        return UIViewController()
    }
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        
        return titleArray[index]
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        
        return CGRect(x: 0, y: kStatusBarAndTopBarHeight - kCellHeight, width: ScreenWidth, height: kCellHeight)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        
        return CGRect(x: 0.0, y:kStatusBarAndTopBarHeight, width: ScreenWidth, height: ScreenHeight - kStatusBarAndTopBarHeight - kTabBarHeight - kBottomSafeHeight)
    }
    
}
