//
//  Response+Codable.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit
import Moya
import CleanJSON

public extension Response {
    
    func mapObject<T: Codable>(_ type: T.Type, atKeyPath path: String? = nil, using decoder: JSONDecoder = CleanJSONDecoder(), failsOnEmptyData: Bool = true) throws -> T {
        
        do {
            return try map(type, atKeyPath: path, using: decoder, failsOnEmptyData: failsOnEmptyData)
        } catch {
            throw MoyaError.objectMapping(error, self)
        }
    }
    
    func mapObject<T: Codable>(_ type: T.Type, using decoder: JSONDecoder = CleanJSONDecoder()) throws -> T {
        
        let response = try mapObject(Model<T>.self, atKeyPath: nil, using: decoder)
        if response.success {
            return response.data
        }
        throw LightError(code: response.code, reason: response.text)
    }
}

