//
//  LDSubjectViewModel.swift
//  Floral
//
//  Created by 文刂Rn on 2016/10/8.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit

private let urlString: String = "http://m.htxq.net/servlet/SysArticleServlet?action=mainList_NewVersion"

class LDSubjectViewModel: NSObject {

    internal lazy var subjectModels : [LDSubjectModel] = [LDSubjectModel]()
    private var currentPageIndex : NSInteger = 0
}


extension LDSubjectViewModel {
    
    func loadNetWorkData(complete : ()->(), failture : (error : NSError)->()) {
        
        currentPageIndex = 0
        
        let params = ["currentPageIndex" : "\(currentPageIndex)"]
        
        
        LDNetworkManager.sharedNetworkManager.post(urlString, params: params, success: { (responseObject) in
            
            let status = responseObject["status"]?.integerValue
            
            guard status == 1 else {
                return
            }
            
            let resultArray = responseObject["result"] as! [[String: AnyObject]]
            
            
            print("====\(resultArray)")
            
            var tempArray = [LDSubjectModel]()
            for dict in resultArray {
                
                let model = LDSubjectModel(dict: dict);
                
                tempArray.append(model)
            }
            
            self.subjectModels = tempArray
            
            self.currentPageIndex = 2
            
            complete()
            
        }) { (error) in
            
            failture(error: error)
            
        }
        
    }
    
    func loadMoreNetworkData(complete : ()->(), failture : (error : NSError)->()) {
        
        let params = ["currentPageIndex" : "\(currentPageIndex)"]
        
        LDNetworkManager.sharedNetworkManager.post(urlString, params: params, success: { (responseObject) in
            
            let status = responseObject["status"]?.integerValue
            
            guard status == 1 else {
                return
            }
            
            let resultArray = responseObject["result"] as! [[String: AnyObject]]
            
            var tempArray = self.subjectModels
            for dict in resultArray {
                
                let model = LDSubjectModel(dict: dict);
                
                tempArray.append(model)
            }
            
            self.subjectModels = tempArray
            
            self.currentPageIndex += 1
            
            complete()
            
        }) { (error) in
            
            failture(error: error)
            
        }
    }
}