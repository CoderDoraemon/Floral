//
//  LDTeacherCourseVM.swift
//  Floral
//
//  Created by LDD on 2019/7/30.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit


class LDTeacherCourseVM: RefreshViewModel {
    
    struct Input {
        let teacherId: String
    }
    struct Output {
        let items: Driver<[CourseModel]>
    }
}

extension LDTeacherCourseVM: ViewModelProtocol {
    
    func transform(input: LDTeacherCourseVM.Input) -> LDTeacherCourseVM.Output {
        
        let itemList = BehaviorRelay<[CourseModel]>(value: [])
        
        var page = 0
        
        /// 上拉刷新
        let loadList = refreshOutput
            .headerRefreshing
            .then(page = 0)
            .flatMapLatest { [unowned self] in
                
                self.request(page: page, teacherId: input.teacherId)
        }
        
        /// 上拉刷新
        let loadMore = refreshOutput
            .footerRefreshing
            .then(page += 1)
            .flatMapLatest { [unowned self] in
                
                self.request(page: page, teacherId: input.teacherId)
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

extension LDTeacherCourseVM {
    
    func request(page: Int, teacherId: String) -> Driver<[CourseModel]> {
        
        return  TeacherApi
            .teacherCourseList(page: page, teacherId: teacherId)
            .request()
            .mapObject([CourseModel].self)
            .trackActivity(self.loading)
            .trackError(self.refreshError)
            .asDriverOnErrorJustComplete()
    }
}
