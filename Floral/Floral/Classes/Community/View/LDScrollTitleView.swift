//
//  LDScrollTitleView.swift
//  Floral
//
//  Created by admin on 2016/10/9.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit

class LDScrollTitleView: UIView {
    
    enum LDTitleColorGradientStyle {
        case RGB    // RGB:默认RGB样式
        case Fill   // 填充
    }
    
    internal var titlesArray: [String]? {
        
        didSet {
            
            
            
        }
        
    }
    
    /// 标题按钮默认选中颜色
    private var norColor: UIColor? {
        
        get {
           
            if self.norColor == nil {
                return UIColor.blackColor()
            }
            return self.norColor
        }
        
    }
    
    /// 标题按钮选中颜色
    private var selColor: UIColor? {
        
        get {
            
            if self.selColor == nil {
                return UIColor.redColor()
            }
            return self.selColor
        }
        
    }
    /// 下标宽度是否相等
    private var isUnderLineEqualTitleWidth: Bool = true
    /// scrollView的背景色
    private var titleScrollViewColor: UIColor?
    /// 标题的高度
    private var titleHeight: CGFloat = 44
    /// 标题的宽度
    private var titleWidth: CGFloat = 0
    /// 标题字体
    private var titleFont: UIFont? {
        get {
            if self.titleFont == nil {
                return UIFont.systemFontOfSize(17)
            }
            return self.titleFont
        }
    }
    /// 所有标题数组
    private var titleLabels: [String] = [String]()
    /// 标题宽度数组
    private var titleWidths: [CGFloat] = [CGFloat]()
    /// 是否显示下标
    private var isShowUnderLine: Bool = true
    /// 是否字体渐变
    private var isShowTitleGradient: Bool = false
    /// 是否字体放大
    private var isShowTitleScale: Bool = false
    /// 是否显示遮盖
    private var isShowTitleCover: Bool = false
    
    private var lastOffsetX: CGFloat = 0
    
    private var isClickTitle: Bool = false
    
    private var isAniming: Bool = false
    
    private var isInitial: Bool = false
    
    private var titleMargin: CGFloat = 0
    
    private var selIndex: NSInteger = 0
    
    
    private var underLineColor: UIColor?
    
    private var underLineH: CGFloat = 0
    
    private var btnsArray: [AnyObject] = [AnyObject]()
    
    private var preSelButton: UIButton?
    
    /// 标题遮盖View
    private lazy var coverView: UIView = {
        
        let coverView: UIView = UIView()
        
        return coverView
        
    }()
    
    private lazy var underLineView: UIView = {
        
        let underLineView: UIView = UIView()
        
        return underLineView
        
    }()
    
    class func scrollTitleView(titleClick: (index: NSInteger)->()) -> LDScrollTitleView {
        
        let titleView = LDScrollTitleView()
        
        titleView.myBlcok = titleClick
        
        return titleView
        
    }
    
    
    private var myBlcok: (index: NSInteger)->() = {_ in }
    
    private lazy var scrollView : UIScrollView = {
        
        let scrollView: UIScrollView = UIScrollView()
        
        return scrollView
        
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.scrollView.frame = self.bounds
        
        let count = self.titlesArray?.count
        
        guard count>0 else {
            return
        }
        
        if count >= 5 {
            self.titleWidth = self.ld_width / 5
        } else {
            self.titleWidth = self.ld_width / CGFloat(count!)
        }
        
        for index in 0 ..< count! {
            
            let btn: UIButton = self.btnsArray[index] as! UIButton
            
            btn.frame = CGRectMake(self.titleWidth * CGFloat(index), 0, self.titleWidth, self.ld_height)
            
            if index == 0 {
                btn.selected = true
                self.preSelButton = btn
            }
            
        }
        
        self.scrollView.contentSize = CGSizeMake(self.titleWidth * CGFloat(count!), 0)
        
    }

}

extension LDScrollTitleView {
    
    private func setup() {
        
        self.addSubview(self.scrollView)
        
    }
    
    private func setupTitleButton(titlesArray: [String]) {
        
        let count = titlesArray.count
        
        for index in 0 ..< count {
            
            let btn: UIButton = UIButton(type: .Custom)
            
            btn.tag = index
            
            btn.backgroundColor = UIColor.clearColor()
            
            btn.setTitle(titlesArray[index], forState: .Normal)
            
            btn.setTitleColor(self.norColor, forState: .Normal)
            btn.setTitleColor(self.selColor, forState: .Selected)
            
            btn.titleLabel?.font = self.titleFont
            
            btn.addTarget(self, action: #selector(self.btnClick(_:)), forControlEvents: .TouchUpInside)
            
            self.scrollView.addSubview(btn)
            
            self.btnsArray.append(btn)
            
        }
        
    }
    
    @objc private func btnClick(btn: UIButton) {
        
        if self.preSelButton == btn {
            return
        }
        
        self.preSelButton?.selected = false
        self.preSelButton = btn
        self.preSelButton?.selected = true
        
        UIView.animateWithDuration(0.25, animations: { 
            self.underLineView.ld_width =
            }, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
        
        self.myBlcok(index: btn.tag)
        
    }
    
}


extension LDScrollTitleView {
    
    func setupTitleEffect(titleEffectBlock: (titleScrollViewColor: UIColor, norColor: UIColor, selColor: UIColor, titleFont: UIFont, titleHeight: Float, titleWidth: Float)->()) {
        
        
    }
    
}
