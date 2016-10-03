//
//  LDSubjectFlowCell.swift
//  Floral
//
//  Created by 文刂Rn on 2016/10/3.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit
import Kingfisher

class LDSubjectFlowCell: UICollectionViewCell {
    
    
    var model : LDSubjectModel? {
        
        didSet {
            
            topImageView.kf_setImageWithURL(NSURL(string: (model?.smallIcon)!)!, placeholderImage: UIImage(named: "placehodler"), optionsInfo:[.Transition(ImageTransition.Fade(1))], progressBlock: nil, completionHandler: nil)
            
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
        contentView.addSubview(categoryNameLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(cutLineView)
        contentView.addSubview(bottomView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        topImageView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(self.contentView)
            make.height.equalTo(80)
        }
        
        categoryNameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(contentView).offset(kMargin)
            make.top.equalTo(topImageView.snp_bottom).offset(kMargin)
            make.right.equalTo(topImageView).offset(-kMargin)
        }
        
        descLabel.snp_makeConstraints { (make) in
            make.left.right.equalTo(categoryNameLabel)
            make.top.equalTo(categoryNameLabel.snp_bottom).offset(kMargin * 0.5)
        }
        
        cutLineView.snp_makeConstraints { (make) in
            make.left.equalTo(contentView).offset(kMargin)
            make.right.equalTo(contentView).offset(-kMargin)
            make.top.equalTo(descLabel.snp_bottom).offset(kMargin * 0.5)
            make.height.equalTo(1.0)
        }
        
        bottomView.snp_makeConstraints { (make) in
            make.left.right.equalTo(contentView)
            make.top.equalTo(cutLineView.snp_bottom)
            make.height.equalTo(35)
        }
        
    }
    
    
    
    // MARK: - lazy
    private lazy var topImageView : UIImageView = {
        
        let topImageView = UIImageView()
        
        return topImageView
        
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
    
    private lazy var bottomView : LDSubjectBottomLeftView = {
        
        let bottomView = LDSubjectBottomLeftView()
        
        return bottomView
        
    }()
    
}
