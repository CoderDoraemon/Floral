//
//  LDRecommendController.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit
import RxCocoa
import Differentiator
import RxDataSources
import RxSwift

class LDRecommendController: CollectionViewController<LDRecommendVM> {
    
    fileprivate let dataSource = BehaviorRelay<[LDRecommendSectionModel]>(value: [])
    fileprivate let banners = BehaviorRelay<[LDRecommendHeaderModel]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: Margin_Left, bottom: Margin_Left, right: Margin_Left)
        collectionView.dataSource = self
        collectionView.delegate = self
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
        
        let input = LDRecommendVM.Input(city: "广州")
        let output = viewModel.transform(input: input)
        
        output.banners.drive(onNext: { [weak self] (list) in
            guard let self = self else { return }
            self.banners.accept(list)
            self.collectionView.reloadData()
        }).disposed(by: rx.disposeBag)
        
        output.items.drive(onNext: { [weak self] (list) in
            guard let self = self else { return }
            self.dataSource.accept(list)
            self.collectionView.reloadData()
        }).disposed(by: rx.disposeBag)
        
    }
    
}


extension LDRecommendController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return dataSource.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let group = dataSource.value[section]
        return group.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withClass: LDRecommendCell.self, for: indexPath)
        
        let group = dataSource.value[indexPath.section]
        cell.model = group.model[indexPath.item]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let group = dataSource.value[indexPath.section]
        let urls = banners.value.map({ $0.imageUrl })
        
        if indexPath.section == 0 && urls.count > 0 {
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: LDRecommendBannerReusableView.self, for: indexPath)
            
            headerView.setData(title: group.title, total: group.total, isMore: group.more,typeID: group.holderId, urls: urls)
            
            headerView.moreBtnTap = { [weak self] (type, title) in
                let vc = LDRecommendMoreController(collectionViewLayout: UICollectionViewFlowLayout())
                vc.type.accept(type)
                vc.navigationTitle.accept(title)
                self?.navigationController?.pushViewController(vc, animated: true)
                }
            
            return headerView
        } else {
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: LDRecommendReusableView.self, for: indexPath)
            
            headerView.setData(title: group.title, total: group.total, isMore: group.more, typeID: group.holderId)
            
            headerView.moreBtnTap = { [weak self] (type, title) in
                let vc = LDRecommendMoreController(collectionViewLayout: UICollectionViewFlowLayout())
                vc.type.accept(type)
                vc.navigationTitle.accept(title)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
            return headerView
        }
    }
}

extension LDRecommendController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let urls = banners.value.map({ $0.imageUrl })
        
        if section == 0 && urls.count > 0 {
            
            return CGSize(width: ScreenWidth, height: autoDistance(230))
        } else {
            
            return CGSize(width: ScreenWidth, height: autoDistance(60))
        }
    }
    
    
}


