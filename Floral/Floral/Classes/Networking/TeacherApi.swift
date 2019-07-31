//
//  TeacherApi.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit
import Moya

enum TeacherApi {
    
    /// 教师列表
    case teacherList(page: Int, category: String)
    /// 教师课程列表
    case teacherCourseList(page: Int, teacherId: String)
}

extension TeacherApi: TargetType {
    
    var path: String {
        
        switch self {
        case .teacherList(_, _):
            return "cactus/researchCommunity/getTeacherList"
        case .teacherCourseList(_, _):
            return "cactus/researchCommunity/getTeacherCourseList"
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
        case .teacherList(let page, let category):
            parameters["index"] = page
            parameters["category"] = category
        case .teacherCourseList(let page, let teacherId):
            parameters["index"] = page
            parameters["teacherId"] = teacherId
        }
        
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
}

