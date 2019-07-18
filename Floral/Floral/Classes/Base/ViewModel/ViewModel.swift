//
//  ViewModel.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit


/// 轻量级 ViewModel，只包含了 error 和耗时操作状态
class ViewModel {
    
    /// 是否正在加载
    let loading = ActivityIndicator()
    /// track error
    let error = ErrorTracker()
    
    required init() {}
    
    deinit {
        print("\(type(of: self)): Deinited")
    }
}

extension ViewModel: HasDisposeBag {}
