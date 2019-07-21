//
//  CollectionReusableView.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 子类直接重写此方法，添加子控件，之后在此方法中调用 setupConstraints 方法进行布局
    func setupUI() {}
    
    /// 布局
    func setupConstraints() {}
    
}
