//
//  LDSubjectController.swift
//  Floral
//
//  Created by 文刂Rn on 16/9/7.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit
import SwiftyJSON

class LDSubjectController: UIViewController {
    
    private var currentPageIndex : NSInteger = 0
    
    private var dataArray : [LDSubjectModel] = [LDSubjectModel]()
    
    private var showFlow : Bool = false
    
    private let subjectViewModel: LDSubjectViewModel = LDSubjectViewModel()
    
    // MARK - Lazy
    private lazy var flowLayout : CHTCollectionViewWaterfallLayout = {
        
        let flow = CHTCollectionViewWaterfallLayout()
        
        flow.columnCount = 1
        flow.minimumColumnSpacing = 10
        flow.minimumInteritemSpacing = 10
        
        flow.sectionInset = UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin);
        
        return flow
    }()
    
    private lazy var collectionView : UICollectionView = {
        
        let collectionView = UICollectionView(frame: CGRectMake(0, kNavgationBarHeightAndStatusBarHeight, kScreenWidth, kScreenHeight - kNavgationBarHeightAndStatusBarHeight), collectionViewLayout: self.flowLayout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()

}

// MARK: - ViewCircl
extension LDSubjectController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavgation()
        
        setup()
        
    }
    
    private func setupNavgation() {
        
        self.navigationItem.title = "专题"
        
        let searchBarButtonItem = UIBarButtonItem(image: UIImage.imageToOriginalImage("nav_subject_search_bar"), style: .Plain, target: self, action: #selector(LDSubjectController.searchBarButtonItemClick))
        let showTypeBarButtonItem = UIBarButtonItem(image: UIImage.imageToOriginalImage("nav_subject_list_bar"), style: .Plain, target: self, action: #selector(LDSubjectController.showTypeBarButtonItemClick))
        self.navigationItem.rightBarButtonItems = [searchBarButtonItem, showTypeBarButtonItem]
        
    }
    
    private func setup() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        view.backgroundColor = UIColor.whiteColor()
        collectionView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        view.addSubview(collectionView)
        
        collectionView.registerClass(LDSubjectCell.self, forCellWithReuseIdentifier: LDSubjectCellIdentifier)
        collectionView.registerClass(LDSubjectFlowCell.self, forCellWithReuseIdentifier: LDSubjectFlowCellIdentifier)
        
        /// 弱引用
        weak var weakSelf = self
        collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            weakSelf!.loadNetWorkData()
        })
        
        self.loadNetWorkData()
        
    }
    
    private func loadNetWorkData() {
        /// 弱引用
        weak var weakSelf = self
        self.subjectViewModel.loadNetWorkData({
            if ((weakSelf?.collectionView.mj_header.isRefreshing()) != nil) {
                weakSelf?.collectionView.mj_header.endRefreshing()
            }
            weakSelf?.collectionView.reloadData()
            }, failture: { (error) in
                
        })
    }
    
    /// MARK - Mothods Click
    @objc private func searchBarButtonItemClick() {
        
        
    }
    @objc private func showTypeBarButtonItemClick() {
        
        self.showFlow = !self.showFlow
        
        self.flowLayout.columnCount = 1
        
        if self.showFlow {
            self.flowLayout.columnCount = 2
        }
        
        self.collectionView.reloadData()
        
    }
    
}

// MARK: - UICollectionViewDataSource
extension LDSubjectController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.subjectViewModel.subjectModels.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if self.subjectViewModel.subjectModels.count != 0 && indexPath.row == (self.subjectViewModel.subjectModels.count - 2) {
            weak var weakSelf = self
            self.subjectViewModel.loadMoreNetworkData({ 
                weakSelf?.collectionView.reloadData()
                }, failture: { (error) in
                    
            })
        }
        
        if !self.showFlow {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(LDSubjectCellIdentifier, forIndexPath: indexPath) as! LDSubjectCell
            cell.model = self.subjectViewModel.subjectModels[indexPath.row]
            
            return cell;
        }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(LDSubjectFlowCellIdentifier, forIndexPath: indexPath) as! LDSubjectFlowCell
        cell.model = self.self.subjectViewModel.subjectModels[indexPath.row]
        
        return cell
        
    }
    
    
}

// MARK: - CHTCollectionViewDelegateWaterfallLayout
extension LDSubjectController: CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let model : LDSubjectModel = self.subjectViewModel.subjectModels[indexPath.item]
        
        if self.showFlow {
            let w = (kScreenWidth - kMargin * 3) * 0.5 - kMargin
            
            return CGSizeMake(w, 180 )
        }
        
        let w = kScreenWidth - kMargin * 4
        
        let testHeight = NSString.stringCalculateLabelHeight("测试", labelWidth: w, labelFont: UIFont.systemFontOfSize(12))
        let Height = NSString.stringCalculateLabelHeight(model.desc!, labelWidth: w, labelFont: UIFont.systemFontOfSize(12))
        
        return CGSizeMake(kScreenWidth - kMargin * 2, (Height == testHeight) ? 340 : 350)
    }
    
}

// MARK: - UITableViewDelegate
extension LDSubjectController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let model : LDSubjectModel = self.subjectViewModel.subjectModels[indexPath.item]
        
        let detailVc: LDSubjectDetailController = LDSubjectDetailController(subjectModel: model)
        
        self.navigationController?.pushViewController(detailVc, animated: true)
        
        
    }
    
}
