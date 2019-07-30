//
//  CourseModel.swift
//  Floral
//
//  Created by LDD on 2019/7/22.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

struct CourseSectionModel: Codable {
    
    /// ID
    let holderId: String
    /// 标题
    let title: String
    /// 总条数
    let total: Int
    /// 是否有更多
    let more: Bool
    /// 模板
    let template: Int
    /// items
    let model: [CourseModel]
}

struct CourseModel: Codable {
    
    let id: String
    /// 描述
    let caption: String
    /// 作者
    let teacher: String
    /// 背景图
    let coverImage: String
    
    /// 描述
    let title: String
    /// 背景图
    let imgUrl: String
    /// 价格
    let price: Double
    /// 阅读量
    let readCount: Int
    
    /// 开始时间
    let beginTimestamp: String
    /// 城市
    let city: String
    /// 价格
    let guidePrice: String
    /// 是否全覆盖
    let isOverfull: String
    /// 分数
    let score: String
    /// 星星
    let star: String
}
