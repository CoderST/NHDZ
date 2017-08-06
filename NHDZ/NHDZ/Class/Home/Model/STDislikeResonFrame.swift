//
//  STDislikeResonFrame.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/3.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
let topLabelHeight : CGFloat = 50
let layoutWidth : CGFloat = sScreenW - 2 * LRMargin
let layoutHeight : CGFloat = 50
fileprivate let bottomViewHeight : CGFloat = 40
class STDislikeResonFrame: NSObject {

    // MARK:- 对外变量
    var dislikeReasonArray : [Dislike_Reason]
    /// 顶部标题
    var topLabelFrame : CGRect = CGRect.zero
    /// 单个图片
    var collecitonViewFrame : CGRect = CGRect.zero
    /// 底部viewFrame
    var bottomViewFrame : CGRect = CGRect.zero

    var viewHeight : CGFloat = 0
    var viewWidth : CGFloat = layoutWidth
    
    init(_ dislikeReasonArray : [Dislike_Reason]){
        self.dislikeReasonArray = dislikeReasonArray
        super.init()
        topLabelFrame = CGRect(x: 0, y: 0, width: layoutWidth, height: topLabelHeight)
        let collectionViewHeight = CGFloat(dislikeReasonArray.count) * layoutHeight
        collecitonViewFrame = CGRect(x: 0, y: topLabelFrame.maxY, width: layoutWidth, height: collectionViewHeight)
        bottomViewFrame = CGRect(x: 0, y: collecitonViewFrame.maxY, width: layoutWidth, height: bottomViewHeight)
        viewHeight = bottomViewFrame.maxY
        
    }
}
