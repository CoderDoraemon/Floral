//
//  RecommendApi.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit
import Moya

enum RecommendApi {
    
    /// 轮播图
    case bannerList
    /// 限时、最新
    case portalList
    /// 分类列表
    case categoryList(page: Int)
    /// 分类更多列表
    case categoryMoreList(page: Int, typeId: String)
}

extension RecommendApi: TargetType {
    
    var path: String {
        
        switch self {
        case .bannerList:
            return "cactus/researchCommunity/getBannerList"
        case .portalList:
            return "cactus/researchCommunity/v2/portal"
        case .categoryList(_):
            return "cactus/researchCommunity/v2/category"
        case .categoryMoreList(_, _):
            return "cactus/researchCommunity/getResearchCommunityByType"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Task {
        
        var parameters: [String: Any] = [:]
        
        switch self {
        case .bannerList, .portalList:
            break
        case .categoryList(let page):
            parameters["index"] = page
        case .categoryMoreList(let page, let typeId):
            parameters["pageIndex"] = page
            parameters["typeId"] = typeId
        }
        
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
}

