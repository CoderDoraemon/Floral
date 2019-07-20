//
//  UUID.swift
//  Floral
//
//  Created by LDD on 2019/7/20.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit


public enum UUIDStyle : Int {
    
    /// 中划线分割 E56D8738-C2EB-4021-A249-D125AAFE7F57
    case canonical
    /// 中划线分割、大括号包裹 {E56D8738-C2EB-4021-A249-D125AAFE7F57}
    case surroundingBraces
    /// urn:uuid:123e4567-e89b-12d3-a456-426655440000
    case urn
    /// 一串字符串 E56D8738C2EB4021A249D125AAFE7F57
    case noHyphens
    
    /// 获取 UUID style 样式
    ///
    /// - Returns: UUID style
    public func next() -> UUIDStyle {
        if let type = UUIDStyle(rawValue: self.rawValue + 1) {
            return type
        }
        
        if let type = UUIDStyle(rawValue: 0) {
            return type
        }
        
        return .canonical
    }
    
    /// UUID 字符串
    public var text : String {
        get {
            switch(self) {
            case .canonical:
                return "Canonical"
            case .surroundingBraces:
                return "Surrounding Braces"
            case .urn:
                return "Uniform Resource Name (URN)"
            case .noHyphens:
                return "No hyphens"
            }
        }
    }
    
    /// UUID style 样式转换
    ///
    /// - Parameter uuid: UUID
    /// - Returns: 对应样式的UUID
    public func uuidString(_ uuid : UUID) -> String {
        
        switch(self) {
        case .canonical:
            return uuid.uuidString
        case .surroundingBraces:
            return "{\(uuid.uuidString)}"
        case .urn:
            return "urn:uuid:\(uuid.uuidString)"
        case .noHyphens:
            let uuidString = uuid.uuidString
            let components = uuidString.components(separatedBy: "-")
            let nohyphensString = components.joined()
            return nohyphensString
        }
        
    }
    
}

extension UUIDStyle : CustomStringConvertible {
    
    public var description: String {
        return self.text
    }
    
}

extension UUID {
    
    public func uuidString(style: UUIDStyle) -> String {
        return style.uuidString(self)
    }
    
}
