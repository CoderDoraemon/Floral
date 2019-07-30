//
//  BannerModel.swift
//  Floral
//
//  Created by LDD on 2019/7/22.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class BannerModel: Codable {
    
    /// 标题
    let title: String
    /// 类型
    let type: Int
    /// 图片
    let imageUrl: String
    /// 跳转ID
    let jumpId: String
    /// 子图
    let detailUrl: String
}
