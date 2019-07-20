//
//  UIButton+Extension.swift
//  Floral
//
//  Created by LDD on 2019/7/20.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit

extension UIButton {
    
    enum ImagePosition {
        /** 图片在左边 */
        case left
        /** 图片在右边 */
        case right
        /** 图片在上面 */
        case top
        /** 图片在底部 */
        case bottom
    }
    
    /// 调整图片位置，返回调整后所需要的size
    /// 调用本方法前，请先确保imageView和titleLabel有值。
    @discardableResult
    func setImage(position: ImagePosition, spacing: CGFloat) -> CGSize {
        guard imageView != nil && titleLabel != nil else {
            return CGSize.zero
        }
        let imageSize = self.imageView!.intrinsicContentSize
        let titleSize = self.titleLabel!.intrinsicContentSize
        
        // 布局
        switch (position) {
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing / 2, bottom: 0, right: spacing / 2)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing / 2, bottom: 0, right: -spacing / 2)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: spacing / 2, bottom: 0, right: spacing / 2)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: (titleSize.width + spacing / 2), bottom: 0, right: -(titleSize.width + spacing / 2))
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageSize.width + spacing / 2), bottom: 0, right: (imageSize.width + spacing / 2))
            contentEdgeInsets = UIEdgeInsets(top: 0, left: spacing / 2, bottom: 0, right: spacing / 2);
        case .top, .bottom:
            let imageOffsetX = (imageSize.width + titleSize.width) / 2 - imageSize.width / 2
            let imageOffsetY = imageSize.height / 2 + spacing / 2
            let titleOffsetX = (imageSize.width + titleSize.width / 2) - (imageSize.width + titleSize.width) / 2
            let titleOffsetY = titleSize.height / 2 + spacing / 2
            let changedWidth = titleSize.width + imageSize.width - max(titleSize.width, imageSize.width)
            let changedHeight = titleSize.height + imageSize.height + spacing - max(imageSize.height, imageSize.height)
            
            if position == .top {
                imageEdgeInsets = UIEdgeInsets(top: -imageOffsetY, left: imageOffsetX, bottom: imageOffsetY, right: -imageOffsetX)
                titleEdgeInsets = UIEdgeInsets(top: titleOffsetY, left: -titleOffsetX, bottom: -titleOffsetY, right: titleOffsetX)
                self.contentEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: -changedWidth / 2, bottom: changedHeight - imageOffsetY, right: -changedWidth / 2);
            } else {
                imageEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: imageOffsetX, bottom: -imageOffsetY, right: -imageOffsetX)
                titleEdgeInsets = UIEdgeInsets(top: -titleOffsetY, left: -titleOffsetX, bottom: titleOffsetY, right: titleOffsetX)
                self.contentEdgeInsets = UIEdgeInsets(top: changedHeight - imageOffsetY, left: -changedWidth / 2, bottom: imageOffsetY, right: -changedWidth / 2);
            }
        }
        return self.intrinsicContentSize
    }
}


