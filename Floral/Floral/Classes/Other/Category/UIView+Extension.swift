//
//  UIView+Extension.swift
//  Floral
//
//  Created by admin on 2016/10/9.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit

extension UIView {
    
    public var ld_x: CGFloat {
        
        get {
            return self.frame.origin.x
        }
        
        set(newVal) {
            var ld_frame: CGRect = self.frame
            ld_frame.origin.x = newVal
            self.frame = ld_frame
            
        }
        
    }
    
    
    public var ld_y: CGFloat {
        
        get {
            return self.frame.origin.y
        }
        
        set(newVal) {
            var ld_frame: CGRect = self.frame
            ld_frame.origin.y = newVal
            self.frame = ld_frame
            
        }
        
    }
    
    public var ld_width: CGFloat {
        
        get {
            return self.frame.size.width
        }
        
        set(newVal) {
            var ld_frame: CGRect = self.frame
            ld_frame.size.width = newVal
            self.frame = ld_frame
            
        }
        
    }
    
    public var ld_height: CGFloat {
        
        get {
            return self.frame.size.height
        }
        
        set(newVal) {
            var ld_frame: CGRect = self.frame
            ld_frame.size.height = newVal
            self.frame = ld_frame
            
        }
        
    }
    
    public var ld_size: CGSize {
        
        get {
            return self.frame.size
        }
        
        set(newVal) {
            var ld_frame: CGRect = self.frame
            ld_frame.size = newVal
            self.frame = ld_frame
            
        }
        
    }
    
    public var ld_centerX: CGFloat {
        
        get {
            return self.center.x
        }
        
        set(newVal) {
            var ld_center: CGPoint = self.center
            ld_center.x = newVal
            self.center = ld_center
            
        }
        
    }
    
    public var ld_centerY: CGFloat {
        
        get {
            return self.center.y
        }
        
        set(newVal) {
            var ld_center: CGPoint = self.center
            ld_center.y = newVal
            self.center = ld_center
            
        }
        
    }
    
}