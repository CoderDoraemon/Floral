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
    
    var currentPageIndex : NSInteger = 0
    
    var dataArray : [LDSubjectModel] = [LDSubjectModel]()
    
    var showFlow : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavgation()
        
        setup()
        
        loadNetworkData()
        
    }
    
    private func setupNavgation() {
        
        self.navigationItem.title = "专题"
        
        let searchBarButtonItem = UIBarButtonItem(image: UIImage.imageToOriginalImage("nav_subject_search_bar"), style: .Plain, target: self, action: #selector(LDSubjectController.searchBarButtonItemClick))
        let showTypeBarButtonItem = UIBarButtonItem(image: UIImage.imageToOriginalImage("nav_subject_list_bar"), style: .Plain, target: self, action: #selector(LDSubjectController.showTypeBarButtonItemClick))
        self.navigationItem.rightBarButtonItems = [searchBarButtonItem, showTypeBarButtonItem]
        
        
        
    }
    
    private func setup() {
        
        view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        collectionView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        view.addSubview(collectionView)
        
        collectionView.registerClass(LDSubjectCell.self, forCellWithReuseIdentifier: LDSubjectCellIdentifier)
        collectionView.registerClass(LDSubjectFlowCell.self, forCellWithReuseIdentifier: LDSubjectFlowCellIdentifier)
        
        /// 弱引用
        weak var weakSelf = self
        collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            weakSelf!.loadNetworkData()
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
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: self.flowLayout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()

}

// MARK: - Network request
extension LDSubjectController {
    
    private func loadNetworkData() {
        
        currentPageIndex = 1
        
        let urlString = "http://m.htxq.net/servlet/SysArticleServlet?action=mainList_NewVersion"
        let params = ["currentPageIndex" : "\(currentPageIndex)"]
        
        
        LDNetworkManager.sharedNetworkManager.post(urlString, params: params, success: { (responseObject) in
            
            if self.collectionView.mj_header.isRefreshing() {
                self.collectionView.mj_header.endRefreshing()
            }
            
            let status = responseObject["status"]?.integerValue
            
            guard status == 1 else {
                return
            }
            
            let resultArray = responseObject["result"] as! [[String: AnyObject]]
            
            var tempArray = [LDSubjectModel]()
            for dict in resultArray {
                
                let model = LDSubjectModel(dict: dict);
                
                tempArray.append(model)
            }
            
            self.dataArray = tempArray
            
            self.collectionView.reloadData()
            
            self.currentPageIndex = 2
            
            }) { (error) in
                
               print("=====\(error))")
                
        }
        
    }
    
    private func loadMoreNetworkData() {
        
        let urlString = "http://m.htxq.net/servlet/SysArticleServlet?action=mainList_NewVersion"
        let params = ["currentPageIndex" : "\(currentPageIndex)"]
        
        LDNetworkManager.sharedNetworkManager.post(urlString, params: params, success: { (responseObject) in
            
            let status = responseObject["status"]?.integerValue
            
            guard status == 1 else {
                return
            }
            
            let resultArray = responseObject["result"] as! [[String: AnyObject]]
            
            var tempArray = self.dataArray
            for dict in resultArray {
                
                let model = LDSubjectModel(dict: dict);
                
                tempArray.append(model)
            }
            
            self.dataArray = tempArray
            
            self.collectionView.reloadData()
            
            self.currentPageIndex += 1
            
        }) { (error) in
            
            print("=====\(error))")
            
        }
        
    }
    
}

// MARK: - UICollectionViewDataSource
extension LDSubjectController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if self.dataArray.count != 0 && indexPath.row == (self.dataArray.count - 2) {
            self.loadMoreNetworkData()
        }
        
        if !self.showFlow {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(LDSubjectCellIdentifier, forIndexPath: indexPath) as! LDSubjectCell
            cell.model = self.dataArray[indexPath.row]
            
            return cell;
        }
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(LDSubjectFlowCellIdentifier, forIndexPath: indexPath) as! LDSubjectFlowCell
        cell.model = self.dataArray[indexPath.row]
        
        return cell
        
    }
    
    
}

extension LDSubjectController: CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let model : LDSubjectModel = self.dataArray[indexPath.item]
        
        if self.showFlow {
            let w = (kScreenWidth - kMargin * 3) * 0.5 - kMargin
            
            return CGSizeMake(w, 180 )
        }
        
        let w = kScreenWidth - kMargin * 4
        
        let testHeight = NSString.stringCalculateLabelHeight("测试", labelWidth: w, labelFont: UIFont.systemFontOfSize(12))
        let Height = NSString.stringCalculateLabelHeight(model.desc!, labelWidth: w, labelFont: UIFont.systemFontOfSize(12))
        
        print("%f-------%f--------%zd", testHeight, Height, indexPath.item)
        
        return CGSizeMake(kScreenWidth - kMargin * 2, (Height == testHeight) ? 340 : 350)
    }
    
}

// MARK: - UITableViewDelegate
extension LDSubjectController: UICollectionViewDelegate {
    
    
}
