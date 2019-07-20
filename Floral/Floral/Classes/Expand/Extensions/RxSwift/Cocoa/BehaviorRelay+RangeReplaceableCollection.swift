//
//  BehaviorRelay+RangeReplaceableCollection.swift
//  RxSwiftX
//
//  Created by Pircate on 2018/8/21.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import RxCocoa

public extension BehaviorRelay where Element: RangeReplaceableCollection {
    
    var append: AnyObserver<Element> {
        
        return AnyObserver { [weak self] event in
            
            guard let self = self else { return }
            
            switch event {
            case .next(let data):
                self.accept(self.value + data)
            case .error(let error):
                print("Data Task Error: \(error)")
            default:
                break
            }
        }
    }
    
    func append(_ newElement: Element.Element) {
        var value = self.value
        value.append(newElement)
        accept(value)
    }
    
    @discardableResult
    func remove(at index: Element.Index) -> Element.Element {
        var value = self.value
        let element = value.remove(at: index)
        accept(value)
        return element
    }
    
    func insert(_ newElement: Element.Element, at index: Element.Index) {
        var value = self.value
        value.insert(newElement, at: index)
        accept(value)
    }
}
