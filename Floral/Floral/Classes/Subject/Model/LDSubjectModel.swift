//
//  LDSubjectModel.swift
//  Floral
//
//  Created by 文刂Rn on 16/9/10.
//  Copyright © 2016年 xfsrn. All rights reserved.
//

import UIKit

class LDSubjectModel: NSObject {

    /// 送💖数量
    var appoint : NSInteger = 0
    /// 用户信息
    var author : LDAuthorModel?
    /// 详细信息
    var category : LDCategoryModel?
    /// 是否查看
    var check : Bool = false
    /// 创建时间
    var createDate : String?
    /// 描述内容
    var desc : String?
    /// 描述标题
    var descTitle : String?
    /// 评论数
    var fnCommentNum : NSInteger = 0
    /// 商品列表
    var goodsList : LDGoodListModel?
    /// 搜索键值
    var keywords : String?
    /// url
    var pageUrl : String?
    /// 分享url
    var sharePageUrl : String?
    /// 小图URL
    var smallIcon : String?
    /// 阅读数量
    var read : NSInteger = 0
    /// 分享数量
    var share : NSInteger = 0
    /// 标题
    var title : String?
    /// 是否是头条
    var top : Bool = false
    /// 是否是音视频
    var video : Bool = false
    /// 音视频URL
    var videoUrl : String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
        if key == "author" {
            if (value != nil) {
                author = LDAuthorModel(dict: value as! Dictionary)
            }
            return
        }
        
        if key == "category" {
            if (value != nil) {
                category = LDCategoryModel(dict: value as! Dictionary)
            }
            return
        }
        
        if key == "goodsList" {
            if (value != nil) {
                goodsList = LDGoodListModel(dict: value as! Dictionary)
            }
            return
        }
        
        super.setValue(value, forKey: key)
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
