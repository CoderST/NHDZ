//
//  STCategoryFrame.swift
//  NHDZ
//
//  Created by xiudou on 2017/8/7.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
let subscriptionButtonW : CGFloat = 50
let subscriptionButtonH : CGFloat = 25
class STDiscoverFrame: NSObject {

    var discoverModel : DiscoverModel
    var iconUrlString : String = ""
    var title : String = ""
    var subTitle : String = ""
    var sonTitle : String = ""
    
    /// 分类头像
    var iconFrame : CGRect = .zero
    /// 标题
    var titleLabelFrame : CGRect = .zero
    /// 子标题
    var subTitleLabelFrame : CGRect = .zero
    /// 订阅 - 总帖数
    var sonTitleLabelFrame : CGRect = .zero
    /// 订阅按钮
    var subscriptionButtonFrame : CGRect = .zero
    /// 线
    var bottomLineFrame : CGRect = .zero
    var cellHeight : CGFloat = discoverIconWH + 20
    
    init(_ discoverModel : DiscoverModel){
        self.discoverModel = discoverModel
        super.init()
        iconUrlString = discoverModel.icon_url
        iconFrame = CGRect(x: discoverMargin, y: discoverMargin, width: discoverIconWH, height: discoverIconWH)
        
        title = discoverModel.name
        let titleSize = title.sizeWithFont(userNameFont)
        titleLabelFrame = CGRect(x: iconFrame.maxX + discoverMargin, y: iconFrame.origin.y, width: titleSize.width, height: titleSize.height)
        
        subTitle = discoverModel.intro
        let subTitleSize = subTitle.sizeWithFont(userSubTitleFont)
        subTitleLabelFrame = CGRect(x: titleLabelFrame.origin.x, y: titleLabelFrame.maxY + 5, width: subTitleSize.width, height: subTitleSize.height)
        
        sonTitle = "\(discoverModel.subscribe_count) 订阅 | 总贴数 \(discoverModel.total_updates)"
        let sonTitleSize = sonTitle.sizeWithFont(userSubTitleFont)
        sonTitleLabelFrame = CGRect(x: titleLabelFrame.origin.x, y: iconFrame.maxY - sonTitleSize.height, width: sonTitleSize.width, height: sonTitleSize.height)
        
        subscriptionButtonFrame = CGRect(x: sScreenW - subscriptionButtonW - discoverMargin, y: (cellHeight - subscriptionButtonH) * 0.5, width: subscriptionButtonW, height: subscriptionButtonH)
        
        bottomLineFrame = CGRect(x: 0, y: cellHeight - 1, width: sScreenW, height: 1)
    }
}
