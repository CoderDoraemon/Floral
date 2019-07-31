//
//  PageViewController.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class PageViewController: WMPageController {
    
    class func pageController() -> PageViewController {
        
        let pageController = self.init()
        
        pageController.titleSizeNormal = autoDistance(16.0)
        pageController.titleSizeSelected = autoDistance(16.0)
        pageController.menuViewStyle = .line
        pageController.titleColorNormal = UIColor.gray
        pageController.titleColorSelected = UIColor.black
        pageController.progressHeight = 2
        pageController.progressWidth = autoDistance(20)
        pageController.menuView?.lineColor = UIColor.black
        
        return pageController
    }
    
    
    /// 标题
    let navigationTitle = BehaviorRelay<String?>(value: nil)
    
    /// 分割线
    lazy var lineView: UIView = {
        
        let lineView = UIView.lineView()
        lineView.frame = CGRect(x: 0, y: kCellHeight - 0.5, width: ScreenWidth, height: 0.5)
        return lineView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tz_addPopGesture(to: self.scrollView)
        fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 30
        
        registerNotification()
        setupUI()
        bindVM()
        
        navigationTitle.bind(to: navigationItem.rx.title).disposed(by: rx.disposeBag)
    }
    
    // MARK: - deinit
    deinit {
        print("\(type(of: self)): Deinited")
    }
    
    // MARK: - didReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("\(type(of: self)): Received Memory Warning")
    }
    
    func setupUI() {
        view.backgroundColor = .white
    }
    
    func bindVM() {}
    
    /// 重复点击 TabBar
    func repeatClickTabBar() {}

}

// MARK: - 通知
extension PageViewController {
    
    // MARK: - 注册通知
    private func registerNotification() {
        
    }
    
    // MARK: - tabBar重复点击
    func tabBarRepeatClick() {
        
        guard view.isShowingOnKeyWindow() else {return}
        repeatClickTabBar()
    }
}
