//
//  LDRecommendReusableView.swift
//  Floral
//
//  Created by LDD on 2019/7/20.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LDRecommendReusableView: CollectionReusableView {
    
    fileprivate let titleLabel = Label().then {
        $0.font = UIFont.autoFontBoldSize(16)
    }
    
    fileprivate let moreButton = Button().then {
        $0.setTitleColor(UIColor.gray, for: .normal)
        $0.titleLabel?.font = UIFont.autoFontSize(15)
        $0.setImage(UIImage(named: "p_back_right"), for: .normal)
    }
    
    fileprivate var typeId: String = ""
    
    /// (typeId, title)
    var moreBtnTap: ((String, String?) -> ())?
    
    override func setupUI() {
        super.setupUI()
        
        addSubview(titleLabel)
        addSubview(moreButton)
        
        moreButton.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                
                if let _block = self.moreBtnTap {
                    _block(self.typeId, self.titleLabel.text ?? "")
                }
                
            }).disposed(by: rx.disposeBag)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-k_Margin_Fifteen)
            make.left.equalToSuperview()
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview()
        }
        
    }
    
    
    func setData(title: String, total: Int, isMore: Bool, typeId: String) {
        
        titleLabel.text = title
        moreButton.isHidden = !isMore
        moreButton.setTitle("查看更多( \(total) )", for: .normal)
        moreButton.setImage(position: .right, spacing: 5)
        self.typeId = typeId
    }
}
