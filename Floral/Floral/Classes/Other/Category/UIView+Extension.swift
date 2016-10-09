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
        
        set {
            var ld_frame: CGRect = self.frame
            ld_frame.origin.x = ld_x
            self.frame = ld_frame
            
        }
        
    }
    
    
    public var ld_y: CGFloat {
        
        get {
            return self.frame.origin.y
        }
        
        set {
            var ld_frame: CGRect = self.frame
            ld_frame.origin.x = ld_y
            self.frame = ld_frame
            
        }
        
    }
    
    public var ld_width: CGFloat {
        
        get {
            return self.frame.size.width
        }
        
        set {
            var ld_frame: CGRect = self.frame
            ld_frame.size.width = ld_width
            self.frame = ld_frame
            
        }
        
    }
    
    public var ld_height: CGFloat {
        
        get {
            return self.frame.size.height
        }
        
        set {
            var ld_frame: CGRect = self.frame
            ld_frame.size.height = ld_height
            self.frame = ld_frame
            
        }
        
    }
    
    public var ld_size: CGSize {
        
        get {
            return self.frame.size
        }
        
        set {
            var ld_frame: CGRect = self.frame
            ld_frame.size = ld_size
            self.frame = ld_frame
            
        }
        
    }
    
    public var ld_centerX: CGFloat {
        
        get {
            return self.center.x
        }
        
        set {
            var ld_center: CGPoint = self.center
            ld_center.x = ld_centerX
            self.center = ld_center
            
        }
        
    }
    
    public var ld_centerY: CGFloat {
        
        get {
            return self.center.y
        }
        
        set {
            var ld_center: CGPoint = self.center
            ld_center.y = ld_centerY
            self.center = ld_center
            
        }
        
    }
    
}