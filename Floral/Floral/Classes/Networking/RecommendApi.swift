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
    case bannerList(city: String)
    /// 限时、最新
    case portalList
    /// 限时、最新
    case categoryList(page: Int)
}

extension RecommendApi: TargetType {
    
    var path: String {
        
        switch self {
        case .bannerList(_):
            return "cactus/researchCommunity/getBannerList"
        case .portalList:
            return "cactus/researchCommunity/v2/portal"
        case .categoryList(_):
            return "cactus/researchCommunity/v2/category"
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
        case .bannerList(let city):
            parameters["city"] = city
            break
        case .portalList:
            break
        case .categoryList(let page):
            parameters["index"] = page
            break
        }
        
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
}

