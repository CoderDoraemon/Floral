//
//  LDSubjectDetailController.swift
//  Floral
//
//  Created by 文刂Rn on 2016/10/8.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit

class LDSubjectDetailController: UIViewController {
    
    private var subjectModel: LDSubjectModel? = nil
    
}

extension LDSubjectDetailController {
    
    convenience init(subjectModel: LDSubjectModel?) {
        self.init()
        
        self.subjectModel = subjectModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavgation()
        
        setupUI()
        
    }
    
    private func setupNavgation() {
        
        view.backgroundColor = UIColor.whiteColor()
        
        navigationItem.title = subjectModel?.title ?? "详情"
        
    }
    
    private func setupUI() {
        
        
        
    }
    
    
    
//    private lazy 
    
    
    
}



