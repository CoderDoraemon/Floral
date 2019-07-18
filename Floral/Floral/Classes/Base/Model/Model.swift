//
//  Model.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

struct Model<T: Codable>: Codable {
    
    let errorCode: Int
    let errorMessage: String
    let result: T
    
    var success: Bool {
        return errorCode == 0
    }
}
