//
//  LDRecommendItem.swift
//  Floral
//
//  Created by LDD on 2019/7/20.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class LDRecommendItem: View {
    
    /// 图片
    fileprivate let imageView = ImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
    }
    /// 标题
    fileprivate let titleLabel = Label().then {
        $0.font = UIFont.autoFontSize(15)
        $0.textColor = UIColor.black
    }
    /// 子标题
    fileprivate let detailLabel = Label().then {
        $0.font = UIFont.autoFontSize(13)
        $0.textColor = UIColor.gray
    }
    
    override func setupUI() {
        super.setupUI()
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(detailLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(autoDistance(144))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(autoDistance(10))
            make.left.equalToSuperview().offset(autoDistance(5))
            make.right.equalToSuperview().offset(-autoDistance(5))
        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(autoDistance(8))
            make.left.right.equalTo(titleLabel)
        }
    }
}

extension LDRecommendItem {
    
    func setData(title: String, detailTitle: String, url: String) {
        
        titleLabel.text = title
        detailLabel.text = detailTitle
        imageView.kf.setImage(with: url.toUrl(), placeholder: UIImage(named: "assets_placeholder_picture"))
    }
    
}


