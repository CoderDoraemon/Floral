//
//  LDCollegeVM.swift
//  Floral
//
//  Created by LDD on 2019/7/21.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class LDCollegeVM: RefreshViewModel {
    
    struct Input {
    }
    
    struct Output {
        let banners: Driver<[BannerModel]>
        let items: Driver<[CourseSectionModel]>
    }
}

extension LDCollegeVM: ViewModelProtocol {
    
    func transform(input: LDCollegeVM.Input) -> LDCollegeVM.Output {
        
        let bannerList = BehaviorRelay<[BannerModel]>(value: [])
        let itemList = BehaviorRelay<[CourseSectionModel]>(value: [])
        
        /// 上拉刷新
        let loadRecommend = refreshOutput
            .headerRefreshing
            .flatMapLatest { (_) -> SharedSequence<DriverSharingStrategy, ([BannerModel], [CourseSectionModel])> in
                
                let loadBranner = CollegeApi
                    .bannerList
                    .request()
                    .mapObject([BannerModel].self)
                    .asDriver(onErrorJustReturn: [])
                
                let loadCategory = CollegeApi
                    .portalList
                    .request()
                    .mapObject([CourseSectionModel].self)
                    .asDriver(onErrorJustReturn: [])
                
                return Driver.zip(loadBranner, loadCategory)
        }
        
        /// 绑定数据
        loadRecommend.drive(onNext: { (arg0) in
            
            let (banner, categoryList) = arg0
            
            bannerList.accept(banner)
            itemList.accept(categoryList)
            
        }).disposed(by: disposeBag)
        
        // 头部刷新状态
        loadRecommend
            .mapTo(false)
            .drive(refreshInput.headerRefreshState)
            .disposed(by: disposeBag)
        
        let output = Output(banners: bannerList.asDriver(), items: itemList.asDriver())
        
        return output
    }
    
}

extension LDCollegeVM {
    
    
}
