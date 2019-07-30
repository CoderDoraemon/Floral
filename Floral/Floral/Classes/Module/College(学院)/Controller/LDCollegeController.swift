//
//  LDCollegeController.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class LDCollegeController: CollectionViewController<LDCollegeVM> {
    
    fileprivate let dataSource = BehaviorRelay<[CourseSectionModel]>(value: [])
    fileprivate let banners = BehaviorRelay<[BannerModel]>(value: [])

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        
        navigationTitle.accept("美学学院")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: Margin_Left, bottom: Margin_Left, right: Margin_Left)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(cellWithClass: LDCollegeImageTopCell.self)
        collectionView.register(cellWithClass: LDCollegeImageLeftCell.self)
        collectionView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: LDRecommendReusableView.self)
        collectionView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: LDRecommendBannerReusableView.self)
        collectionView.refreshHeader = RefreshNormalHeader()
        beginHeaderRefresh()
    }
    
    override func bindVM() {
        super.bindVM()
        
        // 设置代理/数据源
        collectionView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        collectionView.rx.setDataSource(self).disposed(by: rx.disposeBag)
        
        let input = LDCollegeVM.Input()
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

extension LDCollegeController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return dataSource.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let group = dataSource.value[section]
        return group.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = dataSource.value[indexPath.section]
        let model = group.model[indexPath.item]
        
        if group.template == 2 {
            
            let cell = collectionView.dequeueReusableCell(withClass: LDCollegeImageLeftCell.self, for: indexPath)
            
            cell.model = model
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withClass: LDCollegeImageTopCell.self, for: indexPath)
        
        cell.model = model
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let group = dataSource.value[indexPath.section]
        let urls = banners.value.map({ $0.imageUrl })
        
        if indexPath.section == 0 && urls.count > 0 {
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: LDRecommendBannerReusableView.self, for: indexPath)
            
            headerView.setData(title: group.title, total: group.total, isMore: group.more, typeId: group.holderId, urls: urls)
            
            headerView.moreBtnTap = { [weak self] (typeId, title) in
                let vc = LDRecommendMoreController(collectionViewLayout: UICollectionViewFlowLayout())
                vc.typeId.accept(typeId)
                vc.navigationTitle.accept(title)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
            return headerView
        } else {
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: LDRecommendReusableView.self, for: indexPath)
            
            headerView.setData(title: group.title, total: group.total, isMore: group.more, typeId: group.holderId)
            
            headerView.moreBtnTap = { [weak self] (typeId, title) in
                let vc = LDRecommendMoreController(collectionViewLayout: UICollectionViewFlowLayout())
                vc.typeId.accept(typeId)
                vc.navigationTitle.accept(title)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
            return headerView
        }
    }
}

extension LDCollegeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let row: CGFloat = 2
        let w = Int((ScreenWidth  - autoDistance(5) * (row - 1) - Margin_Left * 2) / row)
        
        let group = dataSource.value[indexPath.section]
        
        if group.template == 2 {
            return CGSize(width: CGFloat(ScreenWidth - Margin_Left * 2), height: autoDistance(150))
        }
        
        return CGSize(width: CGFloat(w), height: autoDistance(200))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Margin_Left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return autoDistance(5)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let urls = banners.value.map({ $0.imageUrl })
        
        if section == 0 && urls.count > 0 {
            
            return CGSize(width: ScreenWidth, height: autoDistance(230))
        } else {
            
            return CGSize(width: ScreenWidth, height: autoDistance(60))
        }
    }
    
}
