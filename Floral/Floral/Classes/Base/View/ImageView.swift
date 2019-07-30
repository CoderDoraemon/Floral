//
//  ImageView.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

/// UIImageView
class ImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        setupUI()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() {
        
        layer.masksToBounds = true
        contentMode = .center
        
        hero.modifiers = [.arc]
        
        updateUI()
    }
    
    func updateUI() {
        setNeedsDisplay()
    }

}
