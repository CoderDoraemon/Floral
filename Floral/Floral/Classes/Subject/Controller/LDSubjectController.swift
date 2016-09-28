//
//  LDSubjectController.swift
//  Floral
//
//  Created by 文刂Rn on 16/9/7.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit
import SwiftyJSON

private let LDSubjectCellIdentifier = "LDSubjectCellIdentifier"

class LDSubjectController: UIViewController {
    
    var currentPageIndex : NSInteger = 0
    
    var dataArray : [LDSubjectModel] = [LDSubjectModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavgation()
        
        setup()
        
        loadNetworkData()
        
    }
    
    private func setupNavgation() {
        
        self.navigationItem.title = "专题"
        
    }
    
    private func setup() {
        
        view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        tableView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        view.addSubview(tableView)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44;
        
        tableView.separatorStyle = .None
        
        
        tableView.registerClass(LDSubjectCell.self, forCellReuseIdentifier: LDSubjectCellIdentifier)
        
        
        
    }
    
    // MARK - Lazy
    private lazy var tableView : UITableView = {
        
        let tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.Plain)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()

}

extension LDSubjectController {
    
    private func loadNetworkData() {
        
        currentPageIndex = 1
        
        let urlString = "http://m.htxq.net/servlet/SysArticleServlet?action=mainList_NewVersion"
        let params = ["currentPageIndex" : "\(currentPageIndex)"]
        
        
        LDNetworkManager.sharedNetworkManager.post(urlString, params: params, success: { (responseObject) in
            
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
            
            self.tableView.reloadData()
            
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
            
            self.tableView.reloadData()
            
            self.currentPageIndex += 1
            
        }) { (error) in
            
            print("=====\(error))")
            
        }
        
    }
    
}

extension LDSubjectController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(LDSubjectCellIdentifier, forIndexPath: indexPath) as! LDSubjectCell
        
        cell.model = self.dataArray[indexPath.row]
        
        return cell
        
        
    }
}

extension LDSubjectController: UITableViewDelegate {
    
    
}
