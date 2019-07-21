//
//  CollegeApi.swift
//  Floral
//
//  Created by LDD on 2019/7/21.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit
import Moya

enum CollegeApi {
    
    /// 轮播图
    case bannerList(city: String)
    /// 列表
    case portalList(city: String)
}

extension CollegeApi: TargetType {
    
    var path: String {
        
        switch self {
        case .bannerList(_):
            return "cactus/train/getTopBannerList"
        case .portalList:
            return "cactus/train/portal/v2"
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
        case .portalList(let city):
            parameters["city"] = city
        }
        
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
}


