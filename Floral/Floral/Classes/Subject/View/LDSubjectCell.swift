//
//  LDSubjectCell.swift
//  Floral
//
//  Created by 文刂Rn on 16/9/10.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit
import Kingfisher

class LDSubjectCell: UICollectionViewCell {

    var model : LDSubjectModel? {
        
        didSet {
            
            topImageView.kf_setImageWithURL(NSURL(string: (model?.smallIcon)!)!, placeholderImage: UIImage(named: "placehodler"), optionsInfo:[.Transition(ImageTransition.Fade(1))], progressBlock: nil, completionHandler: nil)
            
            iconImageView.kf_setImageWithURL(NSURL(string: (model?.author?.headImg)!)!, placeholderImage: UIImage(named: "pc_default_avatar"), optionsInfo: [.Transition(ImageTransition.Fade(1))], progressBlock: nil, completionHandler: nil)
            
            vipImageView.image = model?.author!.authImage
            
            nameLabel.text = model?.author?.userName ?? "佚名"
            
            identityLabel.text = model?.author?.identity
            
            categoryLabel.text = "["+(model?.category?.name)!+"]"
            
            categoryNameLabel.text = model?.title
            
            descLabel.text = model?.desc
            
            bottomView.model = model
            
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        backgroundColor = UIColor.whiteColor()
        
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
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        topImageView.snp_makeConstraints { (make) in
            make.top.equalTo(self.contentView)
            make.left.equalTo(self.contentView)
            make.right.equalTo(self.contentView)
            make.height.equalTo(180)
        }
        
        bottomContentView.snp_makeConstraints { (make) in
            make.top.equalTo(topImageView.snp_bottom).offset(kMargin * 0.5)
            make.left.right.equalTo(topImageView)
            make.bottom.equalTo(self.contentView)
        }
        
        
        iconImageView.snp_makeConstraints { (make) in
            make.top.equalTo(bottomContentView).offset(-kMargin * 2)
            make.height.width.equalTo(50)
            make.right.equalTo(bottomContentView).offset(-kMargin)
        }
        
        vipImageView.snp_makeConstraints { (make) in
            make.height.width.equalTo(kMargin)
            make.bottom.right.equalTo(iconImageView)
        }
        
        nameLabel.snp_makeConstraints { (make) in
            make.right.equalTo(iconImageView.snp_left).offset(-kMargin)
            make.top.equalTo(bottomContentView).offset(5)
        }
        
        identityLabel.snp_makeConstraints { (make) in
            make.right.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp_bottom).offset(5)
        }
        
        categoryLabel.snp_makeConstraints { (make) in
            make.top.equalTo(identityLabel.snp_bottom).offset(5)
            make.left.equalTo(bottomContentView).offset(kMargin)
        }

        categoryNameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(categoryLabel)
            make.right.equalTo(iconImageView)
            make.top.equalTo(categoryLabel.snp_bottom).offset(kMargin)
        }
        
        descLabel.snp_makeConstraints { (make) in
            make.left.equalTo(categoryLabel)
            make.right.equalTo(iconImageView)
            make.top.equalTo(categoryNameLabel.snp_bottom).offset(kMargin)
        }
        
        cutLineView.snp_makeConstraints { (make) in
            make.left.equalTo(categoryLabel)
            make.right.equalTo(iconImageView)
            make.top.equalTo(descLabel.snp_bottom).offset(kMargin)
            make.height.equalTo(1.0)
        }

        bottomView.snp_makeConstraints { (make) in
            make.left.right.equalTo(bottomContentView)
            make.top.equalTo(cutLineView.snp_bottom)
            make.height.equalTo(35)
        }
        
    }
    
    
    
    // MARK: - lazy
    private lazy var topImageView : UIImageView = {
        
        let topImageView = UIImageView()
        
        return topImageView
        
    }()
    
    private lazy var bottomContentView : UIView = {
        
        let bottomContentView = UIView()
        
        bottomContentView.backgroundColor = UIColor.whiteColor()
        
        return bottomContentView
        
    }()
    
    private lazy var iconImageView : UIImageView = {
        
        let iconImageView = UIImageView()
        
        iconImageView.layer.cornerRadius = 25
        iconImageView.layer.masksToBounds = true
        
        iconImageView.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
        iconImageView.layer.borderWidth = 1
        
        return iconImageView
        
    }()
    
    private lazy var vipImageView : UIImageView = {
        
        let vipImageView = UIImageView()
        
        return vipImageView
        
    }()
    
    private lazy var nameLabel : UILabel = {
        
        let nameLabel = UILabel()
        
        nameLabel.font = UIFont.systemFontOfSize(12)
        
        return nameLabel
        
    }()
    
    private lazy var identityLabel : UILabel = {
        
        let identityLabel = UILabel()
        
        identityLabel.font = UIFont.systemFontOfSize(10)
        
        return identityLabel
        
    }()
    
    private lazy var categoryLabel : UILabel = {
        
        let categoryLabel = UILabel()
        
        categoryLabel.font = UIFont.systemFontOfSize(12)
        
        return categoryLabel
        
    }()
    
    private lazy var categoryNameLabel : UILabel = {
        
        let categoryNameLabel = UILabel()
        categoryNameLabel.font = UIFont.systemFontOfSize(12)
        
        return categoryNameLabel
        
    }()
    
    private lazy var descLabel : UILabel = {
        
        let descLabel = UILabel()
        descLabel.font = UIFont.systemFontOfSize(12)
        descLabel.numberOfLines = 2
        
        return descLabel
        
    }()
    
    private lazy var cutLineView : UIView = {
    
        let cutLineView = UIView()
        
        cutLineView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        return cutLineView
    
    }()
    
    private lazy var bottomView : LDSubjectBottomRightView = {
        
        let bottomView = LDSubjectBottomRightView()
        
        return bottomView
        
    }()

}
