//
//  Common.swift
//  STPageView
//
//  Created by xiudou on 2016/12/8.
//  Copyright © 2016年 CoderST. All rights reserved.
//
/*
 media_type 0 热门 文字
 media_type 0 文字
 
 media_type 1 图片
 media_type 1 文字 图片
 
 media_type 2 gif
 media_type 2 文字 gif
 
 media_type 3 视频
 media_type 3 文字 视频
 
 media_type 4 文字 多图片
 

 */
import UIKit

// MARK:- 枚举
enum ShowAD_NormalType : Int{
    case Normal = 1   // 普通类型
    case AD = 5       // 广告
}

enum Media_type : Int{
    case Words = 0  // 只有文字
    case Picture_Words = 1  // 图片或者图片和文字
    case GIF_Words = 2  // GIF或者GIF和文字
    case Video_Words = 3  // 视频或者视频和文字
    case MorePicture_Words = 4  // 多图片或者多图片和文字
}

// MARK:- 常量
let sScreenW = UIScreen.main.bounds.width
let sScreenH = UIScreen.main.bounds.height
let screenSize = UIScreen.main.bounds.size
let RowHei : CGFloat = CGFloat(screenSize.width) * 9.0 / 16.0
let NavAndStatusTotalHei : CGFloat = 64.0
let TabbarHei : CGFloat = 49.0
let cellHeight : CGFloat = 44

/// 内同文本行间距
var lineSpace : CGFloat = 5
/// 通用间距
var margin : CGFloat = 10
var commentMargin : CGFloat = 20
/// 用户头像大小
var userIconHW : CGFloat = 25
/// 用户名称字体大小
var userNameFont = UIFont.systemFont(ofSize: 12)
/// 用户子标题
var userSubTitleFont = UIFont.systemFont(ofSize: 10)
/// 评论文字大小
var commentTitleFont = UIFont.systemFont(ofSize: 14)
/// 广告字体
var adTitleFont = userSubTitleFont
/// 文本字体大小
var titleFont = UIFont.systemFont(ofSize: 14)
/// 图片大小
var photoWH : CGFloat = (sScreenW - 4 * margin) / 3
/// 图片间距
var photoMargin : CGFloat = 10

/// cell-图片帖子的最大高度
var CellPictureMaxH : CGFloat = sScreenH
/// 图片帖子一旦超过最大高度,就是用Break
var CellPictureBreakH : CGFloat = 250
/// cell-视频帖子的最大高度
var CellVideoMaxH : CGFloat = sScreenH * 2 / 3
/// 视频帖子一旦超过最大高度,就是用Break
var CellVideoBreakH : CGFloat = sScreenW - 2 * margin

var progressViewWH : CGFloat = 50

var lineViewHeight : CGFloat = 1

// MARK:- 发现
/// 发现轮播高度
var discoverRecommendCycleWH : CGFloat = 250
/// 间距
var discoverMargin : CGFloat = 10
/// 发现分类头像大小
var discoverIconWH : CGFloat = 60

// MARK:- 通知
let STNSNotificationCenter = NotificationCenter.default
 /// menuButton状态改变
let CHANGE_MENUBUTTON_STATE = "changeMenuButtonStateNotificationCenter"
 /// 隐藏menuButton
let HIDE_MENUBUTTON_ACTION = "hiddenMenuAction"
/// 显示menuButton
let SHOW_MENUBUTTON_ACTION = "showMenuAction"
/// 不喜欢类型
let DIDSELECTED_MENUM_TYPE = "didSelectedMenuType"
/// 删除所有的player
let RemoveActionPlayer = "removeActionPlayer"
/// 不喜欢确定和取消通知
let DislikeNSNotification = "dislikeNSNotification"
/// 不喜欢确定和取消通知
let DislikeSuccessNSNotification = "DislikeSuccessNSNotification"
/// 时间
let TimeActionNotification = "TimeActionNotification"

// MARK:- UserDefaults
let STNSUserDefaults = UserDefaults.standard

// MARK:- 颜色
let lineViewColor = UIColor(red: 178.0 / 255.0, green: 178.0 / 255.0, blue: 178.0 / 255.0, alpha: 1.0)

// MARK:- key
let APPKEY = "4f5885cb5270150ce7000016"
let timeModelTime = "timeModelTime"

// MARK:- debugLog
// http://www.jianshu.com/p/88c59eea39f0
func debugLog<T>(_ message : T, file : String = #file, lineNumber : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        print("[\(fileName):line:\(lineNumber)]- \(message)")
        
    #endif
}

// MARK:- 获取MainNavigationController
func getNavigation()->UINavigationController{
    let window = UIApplication.shared.keyWindow!
    let tabVC = window.rootViewController as!UITabBarController
    let nav = tabVC.selectedViewController as!UINavigationController
    return nav
}
