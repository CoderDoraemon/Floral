//
//  Observable+Extension.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension ObservableType where Element == Bool {
    /// Boolean not operator
    public func not() -> Observable<Bool> {
        return self.map(!)
    }
}

public extension Driver {
    
    func then(_ closure: @escaping @autoclosure () -> Void) -> SharedSequence<SharingStrategy, Element> {
        return map {
            closure()
            return $0
        }
    }
}

extension ObservableType {
    
    func catchErrorJustComplete() -> Observable<Element> {
        return catchError { _ in
            return Observable.empty()
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        
        return asDriver { error in
            return Driver.empty()
        }
    }
    
    func then(_ closure: @escaping @autoclosure () throws -> Void) -> Observable<Element> {
        return map {
            try closure()
            return $0
        }
    }
}

extension SharedSequenceConvertibleType {
    
    /**
     Returns an Unit containing as many elements as its input but all of them are the constant provided as a parameter
     
     - parameter value: A constant that each element of the input sequence is being replaced with
     - returns: An unit containing the values `value` provided as a parameter
     */
    public func mapTo<R>(_ value: R) -> SharedSequence<SharingStrategy, R> {
        return map { _ in value }
    }
    
    public func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}



