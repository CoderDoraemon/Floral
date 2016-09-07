//
//  LDNetworkManager.swift
//  Floral
//
//  Created by 文刂Rn on 16/9/7.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit
import Alamofire

class LDNetworkManager: NSObject {
    
    static let sharedNetworkManager: LDNetworkManager = {
        
        let networkManager = LDNetworkManager()
        
        return networkManager
    }()

}

extension LDNetworkManager {
    
    /// POST请求封装
    func  post(urlString : String, params : [String : AnyObject], success : (responseObject : [String : AnyObject])->(), failture : (error : NSError)->()) {
        postRequest(urlString, params: params, success: { (responseObject) in
            success(responseObject : responseObject)
        }) { (error) in
            failture(error: error)
        }
    }
    
    /// GET请求封装
    func get(urlString : String, params : [String : AnyObject], success : (responseObject : [String : AnyObject])->(), failture : (error : NSError)->()) {
        getRequest(urlString, params: params, success: { (responseObject) in
            success(responseObject : responseObject)
        }) { (error) in
            failture(error : error)
        }
    }
    
}


extension LDNetworkManager {
    
    /// 发送POST请求
    func postRequest(urlString : String, params : [String : AnyObject], success : (responseObject : [String : AnyObject])->(), failture : (error : NSError)->()) {
        
        Alamofire.request(.POST,urlString,parameters: params).responseJSON
            {response in
                switch response.result {
                case.Success:
                    if let value = response.result.value as? [String : AnyObject] {
                        success(responseObject: value)
                    }
                case .Failure(let error):
                    failture(error: error)
                }
        }
    }
    
    /// 发送GET请求
    func getRequest(urlString : String, params : [String : AnyObject], success : (responseObject : [String : AnyObject])->(), failture : (error : NSError)->()) {
        
        Alamofire.request(.GET,urlString,parameters: params).responseJSON
            {response in
                switch response.result {
                case.Success:
                    if let value = response.result.value as? [String : AnyObject] {
                        success(responseObject: value)
                    }
                case .Failure(let error):
                    failture(error: error)
                }
        }
    }
    
}