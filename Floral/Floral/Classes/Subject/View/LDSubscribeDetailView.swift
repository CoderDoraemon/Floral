//
//  LDSubscribeDetailView.swift
//  Floral
//
//  Created by 文刂Rn on 2016/10/8.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit
import SnapKit

class LDSubscribeDetailView: UIView {
    
    private var myBlock: (subscribeBtn: UIButton)->() = {_ in }
    
    class func subscribeDetailView(subscribeBtnClick: (subscribeBtn: UIButton)->()) -> LDSubscribeDetailView {
        
        let subscribeDetailView: LDSubscribeDetailView = LDSubscribeDetailView()
        
        subscribeDetailView.myBlock = subscribeBtnClick
        
        return subscribeDetailView
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        addSubview(iconImageView)
        addSubview(nameLabel)
        addSubview(detailLabel)
        addSubview(subscribeBtn)
        addSubview(subcribeLabel)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        iconImageView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(kMargin)
            make.centerY.equalTo(self)
            make.width.height.equalTo(40)
        }
        
        nameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(iconImageView)
            make.left.equalTo(iconImageView.snp_right).offset(5)
        }
        
        detailLabel.snp_makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp_right).offset(5)
            make.bottom.equalTo(iconImageView.snp_bottom)
        }
        
        subscribeBtn.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-kMargin)
            make.height.equalTo(25)
            make.width.equalTo(80)
        }
        
    }
    
    
    @objc private func subscribeBtnClick(btn: UIButton) {
        self.myBlock(subscribeBtn: btn)
    }
    
    
    /// MARK - lazy
    private lazy var iconImageView: UIImageView = {
        
        let iconImageView: UIImageView = UIImageView()
        
        return iconImageView
        
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel: UILabel = UILabel()
        
        return nameLabel
    }()
    
    private lazy var detailLabel: UILabel = {
        
        let detailLabel: UILabel = UILabel()
        
        return detailLabel
    }()
    
    private lazy var subscribeBtn: UIButton = {
        
        let subscribeBtn: UIButton = UIButton(type: UIButtonType.Custom)
        
        subscribeBtn.setTitle("订阅", forState: .Normal)
        subscribeBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        subscribeBtn.setTitle("已订阅", forState: .Selected)
        subscribeBtn.setTitleColor(UIColor.whiteColor(), forState: .Selected)
        
        subscribeBtn.layer.cornerRadius = 5
        subscribeBtn.layer.masksToBounds = true
        
        subscribeBtn.addTarget(self, action: #selector(self.subscribeBtnClick(_:)), forControlEvents: .TouchUpInside)
        
        return subscribeBtn
        
    }()
    
    private lazy var subcribeLabel: UILabel = {
        
        let subcribeLabel: UILabel = UILabel()
        
        return subcribeLabel
    }()
    
}
