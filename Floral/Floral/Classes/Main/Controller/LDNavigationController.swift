//
//  LDNavigationController.swift
//  Floral
//
//  Created by 文刂Rn on 16/9/7.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit

class LDNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        
        
        
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        let navChildCount = viewControllers.count
        
        if navChildCount > 0 {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.imageToOriginalImage("back"), style: .Plain, target: self, action: #selector(self.back))
            viewController.hidesBottomBarWhenPushed = true
            
        }
        super.pushViewController(viewController, animated: true)
        
    }
    
    @objc private func back() {
        self.popViewControllerAnimated(true)
    }

    
    
}
