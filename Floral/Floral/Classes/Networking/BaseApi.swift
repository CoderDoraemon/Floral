//
//  BaseApi.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit
import Moya
import DeviceKit

extension TargetType {
    var baseURL: URL {
        return URL(string: URLConst.shared.baseUrl) ?? emptyUrl
    }
    
    var method: Moya.Method {
        return .post
    }
    
    
    var headers: [String : String]? {
        return [
            "Content-Type" : "application/json",
            "client-app" : "htxq-yjs",
            "client-channel" : "AppStore",
            "client-version" : Device.appVersion,
            "client-terminal" : Device.machineModelName,
            "client-platform" : Device.deviceSystemVersion,
            "client-unique" : UUID().uuidString(style: .canonical)
        ]
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var parameter: [String: Any] {
        return [:]
    }
}
