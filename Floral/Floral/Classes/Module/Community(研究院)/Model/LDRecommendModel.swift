//
//  LDRecommendModel.swift
//  Floral
//
//  Created by LDD on 2019/7/19.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit
import Differentiator

struct LDRecommendSectionModel: Codable {
    
    let holderId: Int
    let title: String
    let total: Int
    let more: Bool
    let model: [LDRecommendModel]
    
    var header: String
    var items: [Item]
}

extension LDRecommendSectionModel: AnimatableSectionModelType {
    typealias Item = Int
    
    var identity: String {
        return header
    }
    
    init(original: LDRecommendSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}

struct LDRecommendModel: Codable {
    
    let id: Int
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
}

struct LDRecommendHeaderModel: Codable {
    
    let title: String
    let type: Int
    let imageUrl: String
    let jumpId: String
    let detailUrl: String
}

struct LDRecommendHotModel: Codable {
    
    let limitedTimeFreeList: LDRecommendSectionModel?
    let latestRecommendList: LDRecommendSectionModel?
}

