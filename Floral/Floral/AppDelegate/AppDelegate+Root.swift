//
//  AppDelegate+Root.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit
import SwiftLocation
import CoreLocation

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
        
        Network.Configuration.default.replacingTask = { target in
            
            switch target.task {
            case let .requestParameters(parameters, encoding):
                
                var params: [String: Any] = parameters
                if let city = Defaults[.cityKey] {
                    params["city"] = city
                }
                
                return .requestParameters(parameters: params, encoding: encoding)
            default:
                return target.task
            }
        }
    }
    
    // MARK: - 初始化定位
    func setupLocation() {
        
        LocationManager.shared.onAuthorizationChange.add { state in
            
            switch state {
            case .disabled:
                // 失效的
                print("定位权限失效的。。。")
            case .undetermined:
                // 未确认
                print("定位权限未确认。。。")
            case .denied:
                // 拒绝
                print("定位权限被拒绝。。。")
            case .restricted:
                // 受限制
                print("定位权限受限制的。。。")
            default:
                // 有效可用
                print("定位权限可用。。。")
            }
            
        }
        
        LocationManager.shared.locateFromIP(service: .ipAPI) { result in
            switch result {
            case .failure(let error):
                debugPrint("An error has occurred while getting info about location: \(error)")
            case .success(let place):
                
                if let coordinates = place.coordinates {
                    
                    let currentLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
                    
                    CLGeocoder().reverseGeocodeLocation(currentLocation, completionHandler: { (placemarks, error) in
                        
                        guard let _placemarks = placemarks,
                            let placemark = _placemarks.first else { return }
                        
                        if var city = placemark.locality {
                            city = city.replacingOccurrences(of: "市", with: "")
                            Defaults[.cityKey] = city
                        }
                        
                    })
                }
                
                
            }
        }
    }
}
