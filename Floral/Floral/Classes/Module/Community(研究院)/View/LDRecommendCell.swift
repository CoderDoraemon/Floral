//
//  LDRecommendCell.swift
//  Floral
//
//  Created by LDD on 2019/7/19.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class LDRecommendCell: CollectionViewCell {
    
    /// 图片
    fileprivate let imageView = ImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 2
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
    
    var model: LDRecommendModel? {
        didSet {
            guard let model = model else { return }
            
            titleLabel.text = model.caption
            detailLabel.text = model.teacher
            imageView.kf.setImage(with: model.coverImage.toUrl(), placeholder: UIImage(named: "assets_placeholder_picture"))
        }
    }
    
    var info: (title: String, detailTitle: String, image: String)? {
        didSet {
            guard let info = info else { return }
            titleLabel.text = info.title
            detailLabel.text = info.detailTitle
            imageView.kf.setImage(with: info.image.toUrl(), placeholder: UIImage(named: "assets_placeholder_picture"))
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
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
