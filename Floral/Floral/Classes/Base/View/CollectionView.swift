//
//  CollectionView.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class CollectionView: UICollectionView {
    
    init() {
        super.init(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
        setupUI()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() {
        self.layer.masksToBounds = true
        self.backgroundColor = .clear
        updateUI()
    }
    
    func updateUI() {
        setNeedsDisplay()
    }
    
    func itemWidth(forItemsPerRow itemsPerRow: Int, withInset inset: CGFloat = 0) -> CGFloat {
        let collectionWidth = Int(frame.size.width)
        if collectionWidth == 0 {
            return 0
        }
        return CGFloat(Int((collectionWidth - (itemsPerRow + 1) * Int(inset)) / itemsPerRow))
    }
    
    func setItemSize(_ size: CGSize) {
        if size.width == 0 || size.height == 0 {
            return
        }
        let layout = (self.collectionViewLayout as? UICollectionViewFlowLayout)!
        layout.itemSize = size
    }
}

