//
//  LDRecommendVM.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class LDRecommendVM: RefreshViewModel {
    
    struct Input {
        let city: String
    }
    struct Output {
        let banners: Driver<[LDRecommendHeaderModel]>
        let items: Driver<[LDRecommendSectionModel]>
    }
}

extension LDRecommendVM: ViewModelProtocol {
    
    func transform(input: LDRecommendVM.Input) -> LDRecommendVM.Output {
        
        let bannerList = BehaviorRelay<[LDRecommendHeaderModel]>(value: [])
        let itemList = BehaviorRelay<[LDRecommendSectionModel]>(value: [])
        
        var page = 0
        
        /// 上拉刷新
        let loadRecommend = refreshOutput
        .headerRefreshing
            .flatMapLatest { (_) -> SharedSequence<DriverSharingStrategy, ([LDRecommendHeaderModel], LDRecommendHotModel, [LDRecommendSectionModel])> in
                
                let loadBranner = RecommendApi
                .bannerList(city: input.city)
                .request()
                .mapObject([LDRecommendHeaderModel].self)
                .asDriver(onErrorJustReturn: [])
                
                let loadHop = RecommendApi
                .portalList
                .request()
                .mapObject(LDRecommendHotModel.self)
                .asDriver(onErrorJustReturn: LDRecommendHotModel(limitedTimeFreeList: nil, latestRecommendList: nil))
                
                let loadCategory = RecommendApi
                    .categoryList(page: page)
                    .request()
                    .mapObject([LDRecommendSectionModel].self)
                    .asDriver(onErrorJustReturn: [])
                
                return Driver.zip(loadBranner, loadHop, loadCategory)
        }
        
        /// 下拉刷新
        let loadMore = refreshOutput
            .footerRefreshing
            .then(page += 1)
            .flatMapLatest { [unowned self] in
                
                RecommendApi
                    .categoryList(page: page)
                    .request()
                    .mapObject([LDRecommendSectionModel].self)
                    .trackActivity(self.loading)
                    .trackError(self.refreshError)
                    .asDriverOnErrorJustComplete()
        }
        
        /// 绑定数据
        loadRecommend.drive(onNext: { (arg0) in
            
            let (headerList, hotItem, categoryList) = arg0
            
            bannerList.accept(headerList)
            
            if let limited = hotItem.limitedTimeFreeList {
                itemList.append(limited)
            }
            
            if let latest = hotItem.latestRecommendList {
                itemList.append(latest)
            }
            
            itemList.accept(itemList.value + categoryList)
            
        }).disposed(by: disposeBag)
        
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
        
        let output = Output(banners: bannerList.asDriver(), items: itemList.asDriver())
        
        return output
    }
    
}

extension LDRecommendVM {
    
    
}
