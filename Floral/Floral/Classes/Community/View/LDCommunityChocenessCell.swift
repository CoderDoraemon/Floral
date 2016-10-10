//
//  LDCommunityChocenessCell.swift
//  Floral
//
//  Created by 文刂Rn on 2016/10/10.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit
import Kingfisher

class LDCommunityChocenessCell: UICollectionViewCell {
    
    var model: LDCommunityModel? {
        
        didSet {
            
            self.imageView.kf_setImageWithURL(NSURL(string: model!.attachment!)!, placeholderImage: UIImage(named: "placehodler"), optionsInfo: [.Transition(ImageTransition.Fade(1))], progressBlock: nil, completionHandler: nil)
            
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
        
        contentView.addSubview(imageView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        self.imageView.snp_makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(self.contentView)
        }
        
    }

    
    
    private lazy var imageView : UIImageView = {
        
        let imageView = UIImageView()
        
        return imageView
        
    }()
    
}
