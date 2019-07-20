//
//  Request+Codable.swift
//  NetworkManager
//
//  Created by LDD on 2019/7/19.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit
import Moya
import Alamofire

// MARK: 设置HTTPS请求权限
class CustomServerTrustPoliceManager : ServerTrustPolicyManager {
    override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        return .disableEvaluation
    }
    public init() {
        super.init(policies: [:])
    }
}

let manager = Manager(
    configuration: URLSessionConfiguration.default,
    serverTrustPolicyManager: CustomServerTrustPoliceManager()
)

// MARK: 请求开始和结束时统一处理
let networkPlugin = NetworkActivityPlugin { (type, targetType) in
    
    switch type {
    case .began:
        //        SSRequestManager.addRequest(target)
        break
    case .ended:
        //        SSRequestManager.cancelRequest(target)
        break
    }
}

func reversedPrint(_ separator: String, terminator: String, items: Any...) {
    
    DispatchQueue.global(qos: .userInitiated).async {
        for item in items {
            print(item, separator: separator, terminator: terminator)
        }
    }
}

// MARK: 请求日志设置
//let networkLoggerPlugin = NetworkLoggerPlugin(verbose: false)
let networkLoggerPlugin = NetworkLoggerPlugin(verbose: true,
                                              output: reversedPrint,
                                              responseDataFormatter: { (data: Data) -> Data in
                                                
                                                do {
                                                    let dataAsJSON = try JSONSerialization.jsonObject(with: data)
                                                    let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
                                                    return prettyData
                                                } catch {
                                                    return data
                                                }
})



// MARK: - 请求域名和路径拼接规则修改
//let endpointClosure = { (target: SSBaseAPI) -> Endpoint in
//
//    // 主要是为了自定义域名和路径的拼接方式,默认方式不能正确拼接当前域名和路径
//    let url = target.baseURL.absoluteString + target.path
//
//    let endpoint = Endpoint(
//        url: url,
//        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
//        method: target.method,
//        task: target.task,
//        httpHeaderFields: target.headers
//    )
//
//    return endpoint
//}
// MARK: 请求属性设置
let RequestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        request.timeoutInterval = 15    //设置请求超时时间
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}
