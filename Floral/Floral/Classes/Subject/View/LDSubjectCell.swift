//
//  LDSubjectCell.swift
//  Floral
//
//  Created by 文刂Rn on 16/9/10.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit

class LDSubjectCell: UITableViewCell {

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    
    private func setupUI() {
        
        backgroundColor = UIColor(red: 241/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1.0)
        
        contentView.addSubview(topImageView)
        contentView.addSubview(bottomContentView)
        bottomContentView.addSubview(iconImageView)
        bottomContentView.addSubview(vipImageView)
        bottomContentView.addSubview(nameLabel)
        bottomContentView.addSubview(identityLabel)
        bottomContentView.addSubview(categoryLabel)
        bottomContentView.addSubview(categoryNameLabel)
        bottomContentView.addSubview(descLabel)
        bottomContentView.addSubview(cutLineView)
        bottomContentView.addSubview(bottomView)
        
        
        
    }
    
    private func make() {
        
        topImageView.snp_makeConstraints { (make) in
            make.top.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.height.equalTo(180)
        }
        
        bottomContentView.snp_makeConstraints { (make) in
            make.top.equalTo(topImageView.snp_bottom).offset(5)
            make.left.right.equalTo(topImageView)
            make.bottom.equalTo(self.contentView)
        }
        
        iconImageView.snp_makeConstraints { (make) in
            make.top.equalTo(bottomContentView).offset(-20)
            make.height.width.equalTo(50)
            make.right.equalTo(bottomContentView).offset(-10)
        }
        
        vipImageView.snp_makeConstraints { (make) in
            make.height.width.equalTo(10)
            make.bottom.right.equalTo(iconImageView)
        }
        
        identityLabel.snp_makeConstraints { (make) in
            make.right.equalTo(iconImageView.snp_left).offset(-10)
            make.bottom.equalTo(iconImageView)
        }
        
        nameLabel.snp_makeConstraints { (make) in
            make.right.equalTo(identityLabel)
            make.bottom.equalTo(identityLabel.snp_top).offset(5)
        }
        
        categoryLabel.snp_makeConstraints { (make) in
            make.top.equalTo(identityLabel.snp_bottom).offset(5)
            make.left.equalTo(bottomContentView).offset(10)
        }
        
        categoryNameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(categoryLabel)
            make.right.equalTo(iconImageView)
            make.top.equalTo(categoryLabel.snp_bottom).offset(10)
        }
        
        descLabel.snp_makeConstraints { (make) in
            make.left.equalTo(categoryLabel)
            make.right.equalTo(iconImageView)
            make.top.equalTo(categoryNameLabel.snp_bottom).offset(10)
        }
        
        cutLineView.snp_makeConstraints { (make) in
            make.left.equalTo(categoryLabel)
            make.right.equalTo(iconImageView)
            make.top.equalTo(descLabel.snp_bottom).offset(10)
            make.height.equalTo(1.0)
        }
        
        bottomView.snp_makeConstraints { (make) in
            make
        }
        
    }
    
    
    
    // MARK: - lazy
    private lazy var topImageView : UIImageView = {
        
        let topImageView = UIImageView()
        
        return topImageView
        
    }()
    
    private lazy var bottomContentView : UIView = {
        
        let bottomContentView = UIView()
        
        return bottomContentView
        
    }()
    
    private lazy var iconImageView : UIImageView = {
        
        let iconImageView = UIImageView()
        
        return iconImageView
        
    }()
    
    private lazy var vipImageView : UIImageView = {
        
        let vipImageView = UIImageView()
        
        return vipImageView
        
    }()
    
    private lazy var nameLabel : UILabel = {
        
        let nameLabel = UILabel()
        
        return nameLabel
        
    }()
    
    private lazy var identityLabel : UILabel = {
        
        let identityLabel = UILabel()
        
        return identityLabel
        
    }()
    
    private lazy var categoryLabel : UILabel = {
        
        let categoryLabel = UILabel()
        
        return categoryLabel
        
    }()
    
    private lazy var categoryNameLabel : UILabel = {
        
        let categoryNameLabel = UILabel()
        
        return categoryNameLabel
        
    }()
    
    private lazy var descLabel : UILabel = {
        
        let descLabel = UILabel()
        
        return descLabel
        
    }()
    
    private lazy var cutLineView : UIView = {
    
        let cutLineView = UIView()
        
        return cutLineView
    
    }()
    
    private lazy var bottomView : LDSubjectBottomView = {
        
        let bottomView = LDSubjectBottomView()
        
        return bottomView
        
    }()

}
