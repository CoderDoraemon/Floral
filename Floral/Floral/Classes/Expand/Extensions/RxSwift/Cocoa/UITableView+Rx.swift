//
//  UITableView+Rx.swift
//  RxSwiftX
//
//  Created by Pircate on 2018/6/4.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import RxSwift
import RxCocoa

public extension Reactive where Base: UITableView {
    
    var isEditing: Binder<Bool> {
        return Binder(base) { tableView, isEditing in
            tableView.setEditing(isEditing, animated: true)
        }
    }
    
    func deselectRow(animated: Bool = true) -> Binder<IndexPath> {
        return Binder(base) { tableView, indexPath in
            tableView.deselectRow(at: indexPath, animated: animated)
        }
    }
    
    var reloadEmptyDataSet: Binder<Void> {
        
        return Binder(base) { tableView, _ in
            tableView.reloadEmptyDataSet()
        }
    }
    
    var reloadData: Binder<Void> {
        
        return Binder(base) { tableView, _ in
            tableView.reloadData()
        }
    }
    
    func scrollToRow(at scrollPosition: UITableView.ScrollPosition, animated: Bool) -> Binder<IndexPath> {
        
        return Binder(base) { tableView, indexPath in
            tableView.scrollToRow(at: indexPath,
                                  at: scrollPosition,
                                  animated: animated)
            tableView.layoutIfNeeded()
        }
    }
}
