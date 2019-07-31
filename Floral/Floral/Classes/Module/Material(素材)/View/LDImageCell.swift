//
//  LDImageCell.swift
//  Floral
//
//  Created by LDD on 2019/7/31.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class LDImageCell: CollectionViewCell {

    /// 图片
    fileprivate let imageView = ImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 2
    }
    
    var coverImage: String = "" {
        didSet {
            imageView.kf.setImage(with: coverImage.toUrl(), placeholder: UIImage(named: "assets_placeholder_picture"))
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(imageView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}
