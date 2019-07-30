//
//  LDRecommendMoreVM.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class LDRecommendMoreVM: RefreshViewModel {
    
    struct Input {
        let typeId: String
    }
    struct Output {
        let items: Driver<[CourseModel]>
    }
}

extension LDRecommendMoreVM: ViewModelProtocol {
    
    func transform(input: LDRecommendMoreVM.Input) -> LDRecommendMoreVM.Output {
        
        let itemList = BehaviorRelay<[CourseModel]>(value: [])
        
        var page = 0
        
        /// 上拉刷新
        let loadRecommend = refreshOutput
            .headerRefreshing
            .then(page = 0)
            .flatMapLatest { [unowned self] in
                
                self.request(page: page, typeId: input.typeId)
        }
        
        /// 上拉刷新
        let loadMore = refreshOutput
            .footerRefreshing
            .then(page += 1)
            .flatMapLatest { [unowned self] in
                
                self.request(page: page, typeId: input.typeId)
        }
        
        /// 绑定数据
        loadRecommend
            .drive(itemList)
            .disposed(by: disposeBag)
        
        loadMore
            .drive(itemList.append)
            .disposed(by: disposeBag)
        
        
        // 头部刷新状态
        loadRecommend
            .mapTo(false)
            .drive(refreshInput.headerRefreshState)
            .disposed(by: disposeBag)
        
        // 尾部刷新状态
        Driver.merge(
            loadRecommend.map { _ in
                RxMJRefreshFooterState.default
            },
            loadMore.map { list in
                
                if list.count > 0 {
                    return RxMJRefreshFooterState.default
                } else {
                    return RxMJRefreshFooterState.noMoreData
                }
            })
            .startWith(.hidden)
            .drive(refreshInput.footerRefreshState)
            .disposed(by: disposeBag)
        
        let output = Output(items: itemList.asDriver())
        
        return output
    }
    
}

extension LDRecommendMoreVM {
    
    func request(page: Int, typeId: String) -> Driver<[CourseModel]> {
        
        return  RecommendApi
            .categoryMoreList(page: page, typeId: typeId)
            .request()
            .mapObject([CourseModel].self)
            .trackActivity(self.loading)
            .trackError(self.refreshError)
            .asDriverOnErrorJustComplete()
    }
}
