//
//  LDScrollTitleView.swift
//  Floral
//
//  Created by admin on 2016/10/9.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit

class LDScrollTitleView: UIView {
    
    internal var titlesArray: [String]? {
        
        didSet {
            
            self.setupUI(titlesArray!)
            
        }
        
    }
    
    /// 标题按钮默认选中颜色
    private lazy var norColor: UIColor = {
        
        let color: UIColor = UIColor.lightGrayColor()
        
        return color
        
    }()
    
    /// 标题按钮选中颜色
    private lazy var selColor: UIColor = {
        
        let color: UIColor = UIColor.redColor()
        
        return color
        
    }()
    /// 下标宽度是否相等
    private var isUnderLineEqualTitleWidth: Bool = true
    /// scrollView的背景色
    private var titleScrollViewColor: UIColor = {
        let bgColor: UIColor = UIColor.whiteColor()
        return bgColor
    }()
    /// 标题的高度
    private var titleHeight: CGFloat = 44
    /// 标题的宽度
    private var titleWidth: CGFloat = 0
    /// 标题字体
    private lazy var titleFont: UIFont = {
        let font: UIFont = UIFont.systemFontOfSize(17)
        return font
    }()
    
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
    
    
    private lazy var underLineColor: UIColor = {
        let color: UIColor = self.selColor
        
        return color
    }()
    
    private var underLineH: CGFloat = 2
    
    private var btnsArray: [AnyObject] = [AnyObject]()
    
    private var preSelButton: UIButton?
    
    
    private lazy var underLineView: UIView = {
        
        let underLineView: UIView = UIView()
        
        return underLineView
        
    }()
    
    
    private var myBlcok: (index: NSInteger)->() = {_ in }
    
    private lazy var scrollView : UIScrollView = {
        
        let scrollView: UIScrollView = UIScrollView()
        
        return scrollView
        
    }()
    
    
    class func scrollTitleView(titleClick: (index: NSInteger)->()) -> LDScrollTitleView {
        
        let titleView = LDScrollTitleView()
        
        titleView.myBlcok = titleClick
        
        return titleView
        
    }
    
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
                
                self.underLineView.ld_width = NSString.stringCalculateLabelWidth((btn.titleLabel?.text)!, labelHeight: CGFloat.max, labelFont: (btn.titleLabel?.font)!)
                
                self.underLineView.ld_centerX = btn.ld_centerX
            }
            
        }
        
        self.scrollView.contentSize = CGSizeMake(self.titleWidth * CGFloat(count!), 0)
        
        self.underLineView.ld_y = self.ld_height - self.underLineH - 1
        
    }
    

}

extension LDScrollTitleView {
    
    private func setup() {
        
        self.addSubview(self.scrollView)
        
    }
    
    private func setupUI(titlesArray: [String]) {
        
        self.btnsArray.removeAll()
        
        self.underLineView.removeFromSuperview()
        
        for view in self.scrollView.subviews {
            if view.isKindOfClass(UIButton) {
                view.removeFromSuperview()
            }
        }
        
        self .setupTitleButton(titlesArray)
        
        if self.isShowUnderLine {
            self.setupUnderLineView()
        }
        
        
    }
    
    private func setupUnderLineView() {
        
        self.scrollView.addSubview(self.underLineView)
        
        self.underLineView.backgroundColor = self.underLineColor
        
        self.underLineView.ld_height = self.underLineH
        
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
        
//        if self.preSelButton == btn {
//            return
//        }
        
        self.preSelButton?.selected = false
        self.preSelButton = btn
        self.preSelButton?.selected = true
        
        UIView.animateWithDuration(0.25, animations: { 
            self.underLineView.ld_width = NSString.stringCalculateLabelWidth((btn.titleLabel?.text)!, labelHeight: CGFloat.max, labelFont: (btn.titleLabel?.font)!)
            self.underLineView.ld_centerX = btn.ld_centerX
            }) { (isFinish) in
               self.myBlcok(index: btn.tag)
        }
        
        
    }
    
}


extension LDScrollTitleView {
    
    internal func setupTitleEffect(title_ScrollViewColor: UIColor?, nor_Color: UIColor?, sel_Color: UIColor?, title_Font: UIFont?, title_Height: CGFloat?, title_Width: CGFloat?) {
        
        if title_ScrollViewColor != nil {
            self.titleScrollViewColor = title_ScrollViewColor!
        }
        
        if nor_Color != nil {
            self.norColor = nor_Color!
        }
        
        if sel_Color != nil {
            self.selColor = sel_Color!
        }
        
        if title_Font != nil {
            self.titleFont = title_Font!
        }
        
        if title_Height != nil {
            self.titleHeight = title_Height!
        }
        if title_Width != nil {
            self.titleWidth = title_Width!
        }
        
        if self.titlesArray?.count > 0 {
            self.setupUI(self.titlesArray!)
        }
        self.layoutIfNeeded()
    }
    
    internal func setUpUnderLineEffect(showUnderLineView: Bool) {
        
        self.isShowUnderLine = showUnderLineView
        
        if self.titlesArray?.count > 0 {
            self.setupUI(self.titlesArray!)
        }
        self.layoutIfNeeded()
    }
    
    internal func changeBtnSelected(index: NSInteger) {
        
        self.btnClick(self.btnsArray[index] as! UIButton)
        
    }
    
}
