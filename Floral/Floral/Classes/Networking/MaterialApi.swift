//
//  MaterialApi.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit
import Moya

enum MaterialApi {
    
    /// 分类列表
    case categoryList
    /// 类容列表
    case contentList(page: Int, categoryId: String)
    /// 推荐列表
    case recommendList
}

extension MaterialApi: TargetType {
    
    var path: String {
        
        switch self {
        case .categoryList:
            return "cactus/material/category/list"
        case .contentList(_, _):
            return "cactus/material/image/top/list"
        case .recommendList:
            return "cactus/material/image/recommend"
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
        case .categoryList, .recommendList:
            break
        case .contentList(let page, let categoryId):
            parameters["index"] = page
            parameters["categoryId"] = categoryId
        }
        
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
}

