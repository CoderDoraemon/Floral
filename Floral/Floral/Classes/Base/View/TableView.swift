//
//  TableView.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

class TableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        estimatedRowHeight = 50
        rowHeight = UITableView.automaticDimension
        backgroundColor = .clear
        if #available(iOS 9.0, *) {
            cellLayoutMarginsFollowReadableWidth = false
        }
        keyboardDismissMode = .onDrag
        separatorStyle = .none
    }

    func updateUI() {
        setNeedsDisplay()
    }
}
