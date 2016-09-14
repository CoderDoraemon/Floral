//
//  LDSubjectBottomView.swift
//  Floral
//
//  Created by 文刂Rn on 16/9/13.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit
import SnapKit

class LDSubjectBottomView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        
        addSubview(seeButton)
        addSubview(loveButton)
        addSubview(commentButton)
        
        commentButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-20)
        }
        
        loveButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self.snp_left).offset(-10)
        }
        
        seeButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self.snp_left).offset(-10)
        }
        
    }
    
    
    // MARK: lazy
    private lazy var seeButton : UIButton = self.createButton("hp_count")
    
    private lazy var loveButton : UIButton = self.createButton("p_zan")
    
    private lazy var commentButton : UIButton = self.createButton("p_comment")
    
    private func createButton(imageNameString: String) -> UIButton {
        
        let btn = UIButton(imageName: imageNameString, target: nil, selector: nil, font: UIFont.systemFontSize(12), titleColor: UIColor.blackColor().colorWithAlphaComponent(0.5), title: "0")
        
        btn.sizeToFit()
        btn.userInteractionEnabled = false
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5)
        
        return btn
        
        
    }
}
