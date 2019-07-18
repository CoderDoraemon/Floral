//
//  String+Extension.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

public extension String {
    
    func toObject<T>(_ : T.Type) -> T? where T: Codable {
        
        guard let data = self.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    func date(withFormat format: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    var htmlAttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    // MARK: - 计算大小
    func size(_ width: CGFloat, _ font: UIFont, _ lineSpeace: CGFloat? = 0) -> CGSize {
        
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        // 行距
        let paragraphStye = NSMutableParagraphStyle()
        paragraphStye.lineSpacing = lineSpeace ?? 0
        // 字体属性
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.paragraphStyle: paragraphStye]
        // 计算宽高
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
        return boundingBox.size
    }
    
    var htmlString: String {
        return htmlAttributedString?.string ?? ""
    }
    
    func getAttributeStringWith(lineSpace: CGFloat
        ) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: self)
        let paragraphStye = NSMutableParagraphStyle()
        
        //调整行间距
        paragraphStye.lineSpacing = lineSpace
        let rang = NSMakeRange(0, CFStringGetLength(self as CFString?))
        attributedString .addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStye, range: rang)
        return attributedString
    }
    
    func classType<T>(_ type: T.Type) -> T.Type? {
        
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("没有获取到命名空间")
            return nil
        }
        guard let nameSpaceClass = NSClassFromString(nameSpace + "." + self) else {
            print("没有获取到字符串对应的Class")
            return nil
        }
        guard let classType = nameSpaceClass as? T.Type else {
            print("没有获取对应控制器的类型")
            return nil
        }
        return classType
    }
    
    func classObject<T: NSObject>(_ type: T.Type) -> T? {
        
        guard let classType = classType(T.self) else {
            return nil
        }
        return classType.init()
    }
}
