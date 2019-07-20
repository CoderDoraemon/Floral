//
//  LDRecommendReusableView.swift
//  Floral
//
//  Created by LDD on 2019/7/20.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class LDRecommendReusableView: CollectionReusableView {
    
    fileprivate let titleLabel = Label().then {
        $0.font = UIFont.autoFontBoldSize(16)
    }
    
    fileprivate let moreButton = Button().then {
        $0.setTitleColor(UIColor.gray, for: .normal)
        $0.titleLabel?.font = UIFont.autoFontSize(15)
        $0.setImage(UIImage(named: "p_back_right"), for: .normal)
    }
    
    override func setupUI() {
        super.setupUI()
        
        
        addSubview(titleLabel)
        addSubview(moreButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-Margin_Left)
            make.left.equalToSuperview()
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview()
        }
        
    }
    
    
    func setData(title: String, total: Int, isMore: Bool) {
        
        titleLabel.text = title
        moreButton.isHidden = !isMore
        moreButton.setTitle("查看更多( \(total) )", for: .normal)
        moreButton.setImage(position: .right, spacing: 5)
    }
}
