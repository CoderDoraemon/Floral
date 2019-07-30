//
//  LDCollegeImageLeftCell.swift
//  Floral
//
//  Created by LDD on 2019/7/30.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class LDCollegeImageLeftCell: LDCollegeImageTopCell {
    
    override func setupConstraints() {
        
        coverImageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.size.equalTo(CGSize(width: autoDistance(100), height: autoDistance(135)))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(teacherLabel)
            make.bottom.equalTo(teacherLabel.snp.top).offset(-k_Margin_Fifteen)
        }
        
        teacherLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(coverImageView.snp.centerY).offset(-k_Margin_Five)
            make.left.equalTo(coverImageView.snp.right).offset(k_Margin_Fifteen)
            make.right.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(coverImageView.snp.centerY).offset(k_Margin_Five)
            make.left.right.equalTo(teacherLabel)
        }
        
        cityLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(dateLabel)
            make.right.equalToSuperview()
            make.left.equalTo(dateLabel.snp.right)
        }
        
        moneyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(k_Margin_Ten)
            make.left.right.equalTo(teacherLabel)
        }
    }
    
}
