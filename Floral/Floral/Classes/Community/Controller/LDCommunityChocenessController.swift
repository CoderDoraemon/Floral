//
//  LDCommunityChocenessController.swift
//  Floral
//
//  Created by 文刂Rn on 2016/10/10.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit

class LDCommunityChocenessController: UIViewController {
    
    private lazy var viewModel: LDCommunityViewModel = LDCommunityViewModel()
    
    private lazy var flowLayout: CHTCollectionViewWaterfallLayout = {
        
        let flow = CHTCollectionViewWaterfallLayout()
        
        flow.columnCount = 2
        flow.minimumColumnSpacing = kMargin * 0.5
        flow.minimumInteritemSpacing = kMargin * 0.5
        
        flow.sectionInset = UIEdgeInsetsMake(kMargin, 0, 0, 0)
        
        return flow
        
    }()

    private lazy var collectionView : UICollectionView = {
        
        let collectionView = UICollectionView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavgationBarHeightAndStatusBarHeight - kTabBarHeight), collectionViewLayout: self.flowLayout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    

    

}

extension LDCommunityChocenessController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        view.backgroundColor = UIColor.whiteColor()
        collectionView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        view.addSubview(collectionView)
        
        collectionView.registerClass(LDCommunityChocenessCell.self, forCellWithReuseIdentifier: LDCommunityChocenessCellIdentifier)
        
        /// 弱引用
        weak var weakSelf = self
        
    }
    
}

// MARK: - UICollectionViewDataSource
extension LDCommunityChocenessController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.viewModel.dataArray.count;
        
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(LDCommunityChocenessCellIdentifier, forIndexPath: indexPath) as! LDCommunityChocenessCell
        
//        cell.model = self.viewModel.dataArray[indexPath.item]
        
        
        return cell
    }
    
    
}

// MARK: - CHTCollectionViewDelegateWaterfallLayout
extension LDCommunityChocenessController: CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake((kScreenWidth - kMargin * 2) * 0.5, (kScreenWidth - kMargin * 2) * 0.5)
    }
    
}


// MARK: - UITableViewDelegate
extension LDCommunityChocenessController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        
        
    }
    
}
