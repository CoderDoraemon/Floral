//
//  LDCommunityController.swift
//  Floral
//
//  Created by 文刂Rn on 16/9/7.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit

class LDCommunityController: UIViewController {
    
    private lazy var contentScrollView: UIScrollView = {
        
        let contentScrollView: UIScrollView = UIScrollView()
        
        contentScrollView.pagingEnabled = true
        
        contentScrollView.showsHorizontalScrollIndicator = false
        
        contentScrollView.bounces = false
        
        contentScrollView.delegate = self
        
        return contentScrollView
    }()
    
    private lazy var titleScrollView: LDScrollTitleView = {
        
        weak var weakSelf = self
        let titleScrollView: LDScrollTitleView = LDScrollTitleView.scrollTitleView({ (index) in
            weakSelf!.addOneChileViewController(index)
        })
        
        return titleScrollView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavgation()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        setupAllChildViewController()
        
        setupContentView()
        
        self.titleScrollView.changeBtnSelected(0)
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.contentScrollView.frame = CGRectMake(0, kNavgationBarHeightAndStatusBarHeight, kScreenWidth, kScreenHeight - kNavgationBarHeightAndStatusBarHeight - kTabBarHeight)
    }
    
    private func setupNavgation() {
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.titleScrollView.titlesArray = ["精选", "圈子", "订阅"]
        
        self.titleScrollView.frame = CGRectMake(0, 0, 180, 44)
        
        self.titleScrollView.setUpUnderLineEffect(true)
        
        self.navigationItem.titleView = self.titleScrollView
        
    }

}

extension LDCommunityController {
    
    private func setupAllChildViewController() {
        self.addChildViewController(LDCommunityChocenessController())
        self.addChildViewController(LDCommunityCircleController())
        self.addChildViewController(LDCommunitySubscribeController())
    }
    
    private func setupContentView() {
        self.view.addSubview(self.contentScrollView)
        self.contentScrollView.contentSize = CGSizeMake(CGFloat(self.childViewControllers.count) * kScreenWidth, 0)
    }
    
    private func addOneChileViewController(index: NSInteger) {
    
        let offSet: CGPoint = CGPointMake(CGFloat(index) * kScreenWidth, 0)
        
        self.contentScrollView.setContentOffset(offSet, animated: false)
        
        let vc: UIViewController = self.childViewControllers[index]
        
        if vc.view.superview != nil {
            return
        }
        
        vc.view.frame = self.contentScrollView.bounds
        
        self.contentScrollView.addSubview(vc.view)
    }
    
}

extension LDCommunityController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let offSetX: CGFloat = scrollView.contentOffset.x
        
        let index: NSInteger = NSInteger(offSetX / kScreenWidth)
        
        self.titleScrollView.changeBtnSelected(index)
    }
    
}
