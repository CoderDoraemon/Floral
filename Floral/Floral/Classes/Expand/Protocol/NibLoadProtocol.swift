//
//  NibLoadProtocol.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

public protocol NibLoadProtocol {
    
    static var Nib: UINib { get }
}

public extension NibLoadProtocol where Self: UIView {
    
    static var Nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    static func loadFromNib(_ nibname: String? = nil) -> Self {
        
        let loadName = nibname == nil ? "\(self)": nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
}

