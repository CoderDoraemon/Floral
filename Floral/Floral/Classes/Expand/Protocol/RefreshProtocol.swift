//
//  RefreshProtocol.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

enum RefreshState {
    
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case noMoreData
}

protocol OutputRefreshProtocol {
    /// 告诉外界的tableView当前的刷新状态
    var refreshState: BehaviorRelay<RefreshState> {get}
}

extension OutputRefreshProtocol {
    
    func autoSetRefreshHeaderState(header: MJRefreshHeader? = nil, footer: MJRefreshFooter? = nil) -> Disposable {
        
        return refreshState.asObservable().subscribe(onNext: { (state) in
            switch state {
                
            case .beingHeaderRefresh:
                header?.beginRefreshing()
            case .endHeaderRefresh:
                header?.endRefreshing()
            case .beingFooterRefresh:
                footer?.beginRefreshing()
            case .endFooterRefresh:
                footer?.endRefreshing()
            case .noMoreData:
                footer?.endRefreshingWithNoMoreData()
            default:
                break
            }
        })
    }
}

protocol Refreshable {
    
}

extension Refreshable where Self: UIViewController {
    
    func initRefreshHeader(_ scrollView: UIScrollView, _ action: (() -> ())?) -> MJRefreshHeader {
        
        scrollView.refreshHeader = RefreshNormalHeader(refreshingBlock: { action?() })
        return scrollView.mj_header
    }
    
    func initRefreshFooter(_ scrollView: UIScrollView, _ action: (() -> ())?) -> MJRefreshFooter {
        
        scrollView.refreshFooter = RefreshFooter(refreshingBlock: { action?() })
        return scrollView.mj_footer
    }
}

extension Refreshable where Self: UIScrollView {
    
    func initRefreshHeader(_ action: (() -> ())?) -> MJRefreshHeader {
        
        mj_header = RefreshNormalHeader(refreshingBlock: { action?() })
        return mj_header
    }
    
    func initRefreshFooter(_ action: (() -> ())?) -> MJRefreshFooter {
        
        mj_footer = RefreshFooter(refreshingBlock: { action?()})
        return mj_footer
    }
}
