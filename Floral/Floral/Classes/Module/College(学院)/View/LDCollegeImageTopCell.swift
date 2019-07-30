//
//  LDCollegeImageTopCell.swift
//  Floral
//
//  Created by LDD on 2019/7/30.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class LDCollegeImageTopCell: CollectionViewCell {
    
    /// 缩略图
    let coverImageView = ImageView()
    /// 标题
    let titleLabel = Label().then {
        $0.font = UIFont.autoFontSize(14)
        $0.textColor = UIColor(hex: "333")
    }
    /// 讲师
    let teacherLabel = Label().then {
        $0.font = UIFont.autoFontSize(12)
        $0.textColor = UIColor(hex: "666")
    }
    /// 日期
    let dateLabel = Label().then {
        $0.font = UIFont.autoFontSize(12)
        $0.textColor = UIColor(hex: "666")
    }
    /// 城市
    let cityLabel = Label().then {
        $0.font = UIFont.autoFontSize(12)
        $0.textColor = UIColor(hex: "666")
        $0.textAlignment = .right
    }
    /// 价格
    let moneyLabel = Label().then {
        $0.font = UIFont.autoFontSize(12)
        $0.textColor = UIColor(hex: "c2ab98")
    }
    
    var model: CourseModel? {
        didSet {
            guard let model = model else { return }
            
            coverImageView.kf.setImage(with: model.coverImage.toUrl(), placeholder: UIImage(named: "assets_placeholder_picture"))
            titleLabel.text = model.title
            teacherLabel.text = model.teacher
            dateLabel.text = model.beginTimestamp
            cityLabel.text = model.city
            moneyLabel.text = model.guidePrice
        }
    }
    
    
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(coverImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(teacherLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(moneyLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        coverImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(coverImageView.snp.width).multipliedBy(0.6)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(coverImageView.snp.bottom).offset(k_Margin_Eight)
            make.left.equalTo(coverImageView).offset(k_Margin_Five)
            make.right.equalTo(coverImageView).offset(-k_Margin_Five)
        }
        
        teacherLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(k_Margin_Ten)
            make.left.right.equalTo(titleLabel)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(teacherLabel.snp.bottom).offset(k_Margin_Ten)
            make.left.equalTo(titleLabel)
        }
        
        cityLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(dateLabel)
            make.right.equalTo(titleLabel)
            make.left.equalTo(dateLabel.snp.right)
        }
        
        moneyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(k_Margin_Ten)
            make.left.right.equalTo(titleLabel)
        }
    }
    
}
