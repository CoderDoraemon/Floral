//
//  LDMaterialListVM.swift
//  Floral
//
//  Created by LDD on 2019/7/31.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class LDMaterialListVM: RefreshViewModel {
    
    struct Input {
        let categoryId: String
    }
    
    struct Output {
        let items: Driver<[CourseModel]>
    }
}

extension LDMaterialListVM: ViewModelProtocol {
    
    func transform(input: LDMaterialListVM.Input) -> LDMaterialListVM.Output {
        
        let itemList = BehaviorRelay<[CourseModel]>(value: [])
        
        var page = 0
        
        /// 上拉刷新
        let loadList = refreshOutput
            .headerRefreshing
            .then(page = 0)
            .flatMapLatest { [unowned self] in
                
                self.request(page: page, categoryId: input.categoryId)
        }
        
        /// 上拉刷新
        let loadMore = refreshOutput
            .footerRefreshing
            .then(page += 1)
            .flatMapLatest { [unowned self] in
                
                self.request(page: page, categoryId: input.categoryId)
        }
        
        /// 绑定数据
        loadList
            .drive(itemList)
            .disposed(by: disposeBag)
        
        loadMore
            .drive(itemList.append)
            .disposed(by: disposeBag)
        
        
        // 头部刷新状态
        loadList
            .mapTo(false)
            .drive(refreshInput.headerRefreshState)
            .disposed(by: disposeBag)
        
        // 尾部刷新状态
        Driver.merge(
            loadList.map { _ in
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

extension LDMaterialListVM {
    
    func request(page: Int, categoryId: String) -> Driver<[CourseModel]> {
        
        return  MaterialApi
            .contentList(page: page, categoryId: categoryId)
            .request()
            .mapObject([CourseModel].self, atKeyPath: "data.list")
            .trackActivity(self.loading)
            .trackError(self.refreshError)
            .asDriverOnErrorJustComplete()
    }
}

