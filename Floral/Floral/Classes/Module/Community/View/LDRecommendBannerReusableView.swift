//
//  LDRecommendHeaderView.swift
//  Floral
//
//  Created by LDD on 2019/7/20.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class LDRecommendBannerReusableView: CollectionReusableView {
    
    fileprivate let cycleView: ZCycleView = ZCycleView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: autoDistance(200)))
    
    
    fileprivate let titleView: LDRecommendReusableView = LDRecommendReusableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: autoDistance(200)))

    
    override func setupUI() {
        super.setupUI()
        
        cycleView.layer.cornerRadius = 2
        cycleView.layer.masksToBounds = true
        
        addSubview(cycleView)
        addSubview(titleView)
        
        titleView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(autoDistance(60))
        }
        
        cycleView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Margin_Left)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(titleView.snp.top)
        }
    }
    
    func setData(title: String, total: Int, isMore: Bool, urls: [String]) {
        
        titleView.setData(title: title, total: total, isMore: isMore)
        
        cycleView.setUrlsGroup(urls)
    }
}
