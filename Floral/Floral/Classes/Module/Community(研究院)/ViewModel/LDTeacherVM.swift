//
//  LDTeacherVM.swift
//  Floral
//
//  Created by LDD on 2019/7/30.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit


class LDTeacherVM: RefreshViewModel {
    
    struct Input {
        let category: String
    }
    struct Output {
        let items: Driver<[TeacherModel]>
    }
}

extension LDTeacherVM: ViewModelProtocol {
    
    func transform(input: LDTeacherVM.Input) -> LDTeacherVM.Output {
        
        let itemList = BehaviorRelay<[TeacherModel]>(value: [])
        
        var page = 0
        
        /// 上拉刷新
        let loadList = refreshOutput
            .headerRefreshing
            .then(page = 0)
            .flatMapLatest { [unowned self] in
                
                self.request(page: page, category: input.category)
        }
        
        /// 上拉刷新
        let loadMore = refreshOutput
            .footerRefreshing
            .then(page += 1)
            .flatMapLatest { [unowned self] in
                
                self.request(page: page, category: input.category)
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

extension LDTeacherVM {
    
    func request(page: Int, category: String) -> Driver<[TeacherModel]> {
        
        return  TeacherApi
            .teacherList(page: page, category: category)
            .request()
            .mapObject([TeacherModel].self)
            .trackActivity(self.loading)
            .trackError(self.refreshError)
            .asDriverOnErrorJustComplete()
    }
}
