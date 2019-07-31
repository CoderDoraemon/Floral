//
//  LDMaterialListController.swift
//  Floral
//
//  Created by LDD on 2019/7/30.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit
import RxCocoa
import Differentiator
import RxDataSources

class LDMaterialListController: CollectionViewController<LDMaterialListVM> {
    
    let categoryId = BehaviorRelay<String>(value: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: k_Margin_Fifteen, bottom: k_Margin_Fifteen, right: k_Margin_Fifteen)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(cellWithClass: LDImageCell.self)
        collectionView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: LDRecommendReusableView.self)
        collectionView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: LDRecommendBannerReusableView.self)
        collectionView.refreshHeader = RefreshNormalHeader()
        collectionView.refreshFooter = RefreshFooter()
        beginHeaderRefresh()
        
    }
    
    override func bindVM() {
        super.bindVM()
        
        //设置代理
        collectionView.rx.setDelegate(self)
            .disposed(by: rx.disposeBag)
        
        let input = LDMaterialListVM.Input(categoryId: categoryId.value)
        let output = viewModel.transform(input: input)
        
        output.items.drive(collectionView.rx.items) { (cv, row, item) in
            
            let cell = cv.dequeueReusableCell(withClass: LDImageCell.self, for: IndexPath(item: row, section: 0))
            
            cell.coverImage = item.entryUrl
            
            return cell
            }
            .disposed(by: rx.disposeBag)
        
        collectionView.rx.modelSelected(TeacherModel.self).subscribe(onNext: { [weak self] (item) in
            
//            let vc = LDTeacherCourseController(collectionViewLayout: UICollectionViewFlowLayout())
//            vc.teacherId.accept(item.teacherId)
//            vc.navigationTitle.accept(item.teacherName)
//            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: rx.disposeBag)
    }
    
}

extension LDMaterialListController: UICollectionViewDelegateFlowLayout {
    
}



