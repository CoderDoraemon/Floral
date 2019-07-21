//
//  LDRecommendMoreController.swift
//  Floral
//
//  Created by LDD on 2019/7/21.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit
import RxCocoa
import Differentiator
import RxDataSources

class LDRecommendMoreController: CollectionViewController<LDRecommendMoreVM> {
    
    let type = BehaviorRelay<Int>(value: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Margin_Left, right: 0)
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
        
        let input = LDRecommendMoreVM.Input(type: type.value)
        let output = viewModel.transform(input: input)
        
        output.items.drive(collectionView.rx.items) { (cv, row, item) in
            
            let cell = cv.dequeueReusableCell(withClass: LDRecommendCell.self, for: IndexPath(item: row, section: 0))
            
            cell.info = (item.title, item.teacher, item.imgUrl)
            
            return cell
            }
            .disposed(by: rx.disposeBag)
        
    }
    
}

extension LDRecommendMoreController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let row: CGFloat = 3
        let w = Int((ScreenWidth  - autoDistance(5) * (row - 1)) / row)
        
        return CGSize(width: CGFloat(w), height: autoDistance(200))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Margin_Left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return autoDistance(5)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: ScreenWidth, height: Margin_Left)
    }
    
    
}



