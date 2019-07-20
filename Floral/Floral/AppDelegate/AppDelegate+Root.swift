//
//  AppDelegate+Root.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    // MARK: - 设置根控制器
    /// 设置根控制器
    func initRootViewController() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
    }

    
    // MARK: - 初始化网络请求
    func setupNetwork() {
        
        Network.Configuration.default.timeoutInterval = 20
        Network.Configuration.default.plugins = [networkLoggerPlugin, networkPlugin]
        
//        Network.Configuration.default.replacingTask = { target in
//            
//            switch target.task {
//            case let .requestParameters(parameters, encoding):
//                
//                let params: [String: Any] = [
//                    "os": "iOS",
//                    "app": "GSApp",
//                    "appVersion": "3.7.4",
//                    "request": parameters
//                ]
//                return .requestParameters(parameters: params, encoding: encoding)
//            default:
//                return target.task
//            }
//        }
    }
}
