//
//  STCommentModelFrame.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/5.
//  Copyright © 2017年 CoderST. All rights reserved.
//  一条评论的Frame

import UIKit

class STCommentModelFrame: NSObject {

    var userName : String = ""
    var timeString : String = ""
    var content : String = ""
    
    var singleCommentModel : STSingleCommentModel
    /// 用户头像
    var userIconViewFrame : CGRect = .zero
    /// 用户名称
    var userNameLabelFrame : CGRect = .zero
    /// 评论时间
    var timeLabelFrame : CGRect = .zero
    /// 评论内容
    var contentLabelFrame : CGRect = .zero
    /// 赞按钮
    var zanButtonFrame : CGRect = .zero
    /// 分享按钮
    var shareButtonFrame : CGRect = .zero
    /// 底部灰色线
    var bottomLineViewFrame : CGRect = .zero
    
    /// cell高度
    var cellHeight : CGFloat = 0
    
    init(_ singleCommentModel : STSingleCommentModel) {
        self.singleCommentModel = singleCommentModel
        super.init()
        
        // 头像
        userIconViewFrame = CGRect(x: commentMargin, y: commentMargin, width: userIconHW, height: userIconHW)
      
        // 名称
        userName = singleCommentModel.user_name
        let userNameSize = userName.sizeWithFont(userNameFont)
        userNameLabelFrame = CGRect(x: userIconViewFrame.maxX + margin, y: userIconViewFrame.origin.y, width: userNameSize.width, height: userNameSize.height)

        // 时间
        let time = "\(singleCommentModel.create_time)"
        timeString = Date.createDateString(time)
        let timeLabelSize = timeString.sizeWithFont(userSubTitleFont)
        timeLabelFrame = CGRect(x: userNameLabelFrame.origin.x, y: userIconViewFrame.maxY - timeLabelSize.height, width: timeLabelSize.width, height: timeLabelSize.height)
        
        // 内容
        content = singleCommentModel.text
        let maxWidth : CGFloat = sScreenW - userNameLabelFrame.origin.x - 1.5 * commentMargin
        let contentSize = content.sizeWithFont(commentTitleFont, size: CGSize(width: maxWidth, height: CGFloat(MAXFLOAT)))
        contentLabelFrame = CGRect(x: userNameLabelFrame.origin.x, y: userIconViewFrame.maxY + margin, width: contentSize.width, height: contentSize.height)
        
        bottomLineViewFrame = CGRect(x: 0, y: contentLabelFrame.maxY + commentMargin, width: sScreenW, height: 1)
        
        cellHeight = bottomLineViewFrame.maxY
        
    }
}
