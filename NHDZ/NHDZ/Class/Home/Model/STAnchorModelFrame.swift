//
//  STAnchorModelFrame.swift
//  NHDZ
//
//  Created by xiudou on 2017/8/16.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit

class STAnchorModelFrame: NSObject {

    var userIconString : String = ""
    var userNameLabelString : String = ""
    var localLabelString : String = ""
    var userImageViewString : String = ""
    
    /// 头像
    var userIconFrame : CGRect = .zero
    
    /// 名称
    var userNameLabelFrame : CGRect = .zero
    
    /// 地址
    var localLabelFrame : CGRect = .zero
    
    /// 图片
    var userImageViewFrame : CGRect = .zero
    
    /// cell高
    var cellHeight : CGFloat = 0
    
    var anchor : Anchor
    init(_ anchor : Anchor) {
        self.anchor = anchor
        super.init()
        /// 头像
        userIconString = anchor.smallpic
        userIconFrame = CGRect(x: margin, y: margin, width: userIconHW, height: userIconHW)
        
        /// 名称
        userNameLabelString = anchor.myname
        let userNameLabelSize = userNameLabelString.sizeWithFont(userNameFont)
        userNameLabelFrame = CGRect(x: userIconFrame.maxX + margin, y: userIconFrame.origin.y, width: userNameLabelSize.width, height: userNameLabelSize.height)
        
        /// 地址
        localLabelString = anchor.gps
        let localLabelSize = localLabelString.sizeWithFont(userSubTitleFont)
        localLabelFrame = CGRect(x: userNameLabelFrame.origin.x, y: userIconFrame.maxY - localLabelSize.height, width: localLabelSize.width, height: localLabelSize.height)

        /// 图片
        userImageViewString = anchor.bigpic
        userImageViewFrame = CGRect(x: 0, y: userIconFrame.maxY + margin, width: sScreenW, height: sScreenW)
        
        cellHeight = userImageViewFrame.maxY
    }
}
