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
        let banners: Driver<[BannerModel]>
        let items: Driver<[CourseSectionModel]>
    }
}

extension LDRecommendVM: ViewModelProtocol {
    
    func transform(input: LDRecommendVM.Input) -> LDRecommendVM.Output {
        
        let bannerList = BehaviorRelay<[BannerModel]>(value: [])
        let itemList = BehaviorRelay<[CourseSectionModel]>(value: [])
        
        var page = 0
        
        /// 上拉刷新
        let loadRecommend = refreshOutput
        .headerRefreshing
            .flatMapLatest { (_) -> SharedSequence<DriverSharingStrategy, ([BannerModel], LDRecommendHotModel, [CourseSectionModel])> in
                
                let loadBranner = RecommendApi
                .bannerList
                .request()
                .mapObject([BannerModel].self)
                .asDriver(onErrorJustReturn: [])
                
                let loadHop = RecommendApi
                .portalList
                .request()
                .mapObject(LDRecommendHotModel.self)
                .asDriver(onErrorJustReturn: LDRecommendHotModel(limitedTimeFreeList: nil, latestRecommendList: nil))
                
                let loadCategory = RecommendApi
                    .categoryList(page: page)
                    .request()
                    .mapObject([CourseSectionModel].self)
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
                    .mapObject([CourseSectionModel].self)
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
        
        let output = Output(banners: bannerList.asDriver(), items: itemList.asDriver())
        
        return output
    }
    
}

extension LDRecommendVM {
    
    
}
