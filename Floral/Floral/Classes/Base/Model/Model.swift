//
//  Model.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

struct Model<T: Codable>: Codable {
    
    let code: Int
    let text: String
    let data: T
    
    var success: Bool {
        return code == 0
    }
}
