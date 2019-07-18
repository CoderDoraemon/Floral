//
//  UICollectionView+Rx.swift
//  RxSwiftX
//
//  Created by Pircate on 2018/6/4.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import UIKit
import RxSwift

extension Reactive where Base: UICollectionView {
    
    var reloadEmptyDataSet: Binder<Void> {
        
        return Binder(base) { collectionView, _ in
            collectionView.reloadEmptyDataSet()
        }
    }
    
    var reloadData: Binder<Void> {
        
        return Binder(base) { collectionView, _ in
            collectionView.reloadData()
        }
    }
    
    func scrollToItem(at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) -> Binder<IndexPath> {
        
        return Binder(base) { collectionView, indexPath in
            
            collectionView.scrollToItem(at: indexPath,
                                        at: scrollPosition,
                                        animated: animated)
        }
    }
}
