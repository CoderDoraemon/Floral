//
//  LDTodayRecommendVM.swift
//  Floral
//
//  Created by LDD on 2019/7/21.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class LDTodayRecommendVM: RefreshViewModel {
    
    struct Input {
        let categoryId: String
    }
    
    struct Output {
        let banners: Driver<[CourseModel]>
        let items: Driver<[CourseSectionModel]>
    }
}

extension LDTodayRecommendVM: ViewModelProtocol {
    
    func transform(input: LDTodayRecommendVM.Input) -> LDTodayRecommendVM.Output {
        
        let bannerList = BehaviorRelay<[CourseModel]>(value: [])
        let itemList = BehaviorRelay<[CourseSectionModel]>(value: [])
        
        var page = 0
        
        /// 上拉刷新
        let loadList = refreshOutput
            .headerRefreshing
            .then(page = 0)
            .flatMapLatest { (_) -> SharedSequence<DriverSharingStrategy, ([CourseModel], [CourseSectionModel])> in
                
                let loadBranner = MaterialApi
                    .contentList(page: page, categoryId: input.categoryId)
                    .request()
                    .mapObject([CourseModel].self, atKeyPath: "data.list")
                    .asDriver(onErrorJustReturn: [])
                
                let loadCategory = MaterialApi
                    .recommendList
                    .request()
                    .mapObject([CourseSectionModel].self)
                    .asDriver(onErrorJustReturn: [])
                
                return Driver.zip(loadBranner, loadCategory)
        }
        
        /// 绑定数据
        loadList.drive(onNext: { (arg0) in
            
            let (banner, categoryList) = arg0
            
            bannerList.accept(banner)
            itemList.accept(categoryList)
            
        }).disposed(by: disposeBag)
        
        // 头部刷新状态
        loadList
            .mapTo(false)
            .drive(refreshInput.headerRefreshState)
            .disposed(by: disposeBag)
        
        let output = Output(banners: bannerList.asDriver(), items: itemList.asDriver())
        
        return output
    }
    
}

extension LDTodayRecommendVM {
    
    
}
