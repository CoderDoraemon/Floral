//
//  LDMaterialController.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class LDMaterialController: PageViewController {
    
    /** 默认Vip */
    fileprivate var titleArray: [LDMaterialTitleModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if lineView.superview == nil {
            menuView?.addSubview(lineView)
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        scrollView?.backgroundColor = UIColor.white
        view.backgroundColor = UIColor.white
        
        
    }
    
    override func bindVM() {
        super.bindVM()
        
        MaterialApi
            .categoryList
            .request()
            .mapObject([LDMaterialTitleModel].self)
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] (titles) in
                guard let self = self else { return }
                
                let item: LDMaterialTitleModel = LDMaterialTitleModel()
                item.id = "0"
                item.title = "今日推荐"
                
                self.titleArray = [item] + titles
                
                self.reloadData()
                
            }).disposed(by: rx.disposeBag)
    }
}


extension LDMaterialController {
    
    override func menuView(_ menu: WMMenuView!, widthForItemAt index: Int) -> CGFloat {
        
        let item = titleArray[index]
        
        let w = item.title.size(CGFloatHUGE, UIFont.systemFont(ofSize: titleSizeNormal)).width
        
        return w + 20
    }
    
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        
        return titleArray.count
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = autoDistance(10)
        layout.minimumInteritemSpacing = autoDistance(10)
        let row: CGFloat = 3
        let w = Int((ScreenWidth - k_Margin_Fifteen * 2 - autoDistance(10) * (row - 1)) / row)
        layout.itemSize = CGSize(width: w, height: w)
        
        let item = titleArray[index]
        
        switch index {
        case 0:
            let vc = LDTodayRecommendController(collectionViewLayout: layout)
            vc.categoryId.accept(item.id)
            return vc
        default:
            let vc = LDMaterialListController(collectionViewLayout: layout)
            vc.categoryId.accept(item.id)
            return vc
        }
    }
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        
        let item = titleArray[index]
        
        return item.title
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        
        return CGRect(x: 0, y: kStatusBarAndTopBarHeight, width: ScreenWidth, height: kCellHeight)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        
        return CGRect(x: 0.0, y:kStatusBarAndTopBarHeight + kCellHeight, width: ScreenWidth, height: ScreenHeight - kStatusBarAndTopBarHeight - kTabBarHeight - kBottomSafeHeight - kCellHeight)
    }
    
}

