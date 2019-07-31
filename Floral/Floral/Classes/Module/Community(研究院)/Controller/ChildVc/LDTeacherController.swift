//
//  LDTeacherController.swift
//  Floral
//
//  Created by LDD on 2019/7/30.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit
import RxCocoa
import Differentiator
import RxDataSources

class LDTeacherController: CollectionViewController<LDTeacherVM> {
    
    let typeId = BehaviorRelay<String>(value: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: k_Margin_Fifteen, right: 0)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(cellWithClass: LDRecommendCell.self)
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
        
        let input = LDTeacherVM.Input(category: "1")
        let output = viewModel.transform(input: input)
        
        output.items.drive(collectionView.rx.items) { (cv, row, item) in
            
            let cell = cv.dequeueReusableCell(withClass: LDRecommendCell.self, for: IndexPath(item: row, section: 0))
            
            cell.info = (item.teacherName, item.teacherCountry, item.teacherPhoto)
            
            return cell
            }
            .disposed(by: rx.disposeBag)
        
        collectionView.rx.modelSelected(TeacherModel.self).subscribe(onNext: { [weak self] (item) in
            
            let vc = LDTeacherCourseController(collectionViewLayout: UICollectionViewFlowLayout())
            vc.teacherId.accept(item.teacherId)
            vc.navigationTitle.accept(item.teacherName)
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: rx.disposeBag)
    }
    
}

extension LDTeacherController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let row: CGFloat = 3
        let w = Int((ScreenWidth  - autoDistance(5) * (row - 1)) / row)
        
        return CGSize(width: CGFloat(w), height: autoDistance(200))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return k_Margin_Fifteen
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return autoDistance(5)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: ScreenWidth, height: k_Margin_Fifteen)
    }
    
}



