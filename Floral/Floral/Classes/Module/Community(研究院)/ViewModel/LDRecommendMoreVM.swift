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
        let type: Int
    }
    struct Output {
        let items: Driver<[LDRecommendModel]>
    }
}

extension LDRecommendMoreVM: ViewModelProtocol {
    
    func transform(input: LDRecommendMoreVM.Input) -> LDRecommendMoreVM.Output {
        
        let itemList = BehaviorRelay<[LDRecommendModel]>(value: [])
        
        var page = 0
        
        /// 上拉刷新
        let loadRecommend = refreshOutput
            .headerRefreshing
            .then(page = 0)
            .flatMapLatest { [unowned self] in
                
                self.request(page: page, type: input.type)
        }
        
        /// 上拉刷新
        let loadMore = refreshOutput
            .footerRefreshing
            .then(page += 1)
            .flatMapLatest { [unowned self] in
                
                self.request(page: page, type: input.type)
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
            loadMore.map { _ in
                RxMJRefreshFooterState.default
            })
            .startWith(.hidden)
            .drive(refreshInput.footerRefreshState)
            .disposed(by: disposeBag)
        
        let output = Output(items: itemList.asDriver())
        
        return output
    }
    
}

extension LDRecommendMoreVM {
    
    func request(page: Int, type: Int) -> Driver<[LDRecommendModel]> {
        
        return  RecommendApi
            .categoryMoreList(page: page, type: type)
            .request()
            .mapObject([LDRecommendModel].self)
            .trackActivity(self.loading)
            .trackError(self.refreshError)
            .asDriverOnErrorJustComplete()
    }
}
