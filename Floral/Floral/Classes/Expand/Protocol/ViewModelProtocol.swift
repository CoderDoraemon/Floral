//
//  ViewModelProtocol.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

protocol ViewModelProtocol {

    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
