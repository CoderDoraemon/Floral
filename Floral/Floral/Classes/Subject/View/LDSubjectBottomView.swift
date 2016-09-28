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

    var model : LDSubjectModel? {
        
        didSet {
            
            let fnCommentNum = model?.fnCommentNum
            let appoint = model?.appoint
            let read = model?.read
            
            commentButton.setTitle("\(fnCommentNum!)", forState: .Normal)
            loveButton.setTitle("\(appoint!)", forState: .Normal)
            seeButton.setTitle("\(read!)", forState: .Normal)
            
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
        
        addSubview(commentButton)
        addSubview(seeButton)
        addSubview(loveButton)
        
        commentButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self.snp_right).offset(-10)
        }
        
        loveButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(commentButton.snp_left).offset(-10)
        }
        
        seeButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(loveButton.snp_left).offset(-10)
        }
        
    }
    
    
    // MARK: lazy
    private lazy var seeButton : UIButton = self.createButton("hp_count")
    
    private lazy var loveButton : UIButton = self.createButton("p_zan")
    
    private lazy var commentButton : UIButton = self.createButton("p_comment")
    
    private func createButton(imageNameString: String) -> UIButton {
        
        
        let btn = UIButton(imageName: imageNameString, target: nil, selector: nil, font: UIFont.systemFontOfSize(12), titleColor: UIColor.blackColor().colorWithAlphaComponent(0.5), title: "0")
        
        btn.sizeToFit()
        btn.userInteractionEnabled = false
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        
        return btn
        
        
    }
}
