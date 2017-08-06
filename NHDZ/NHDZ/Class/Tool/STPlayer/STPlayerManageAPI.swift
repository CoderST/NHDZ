//
//  STPlayerManageAPI.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/3.
//  Copyright © 2017年 CoderST. All rights reserved.

/**  
     1 : 在点击开始播放按钮实现1
     2 : 退出界面时实现2
     3 : 在cell滚出界面时候didEndDisplaying发送下面通知
     NotificationCenter.default.post(name: Notification.Name(rawValue: RemoveActionPlayer), object: cell)
 **/

import UIKit

class STPlayerManageAPI: NSObject {
    
    static let shareInstance : STPlayerManageAPI = STPlayerManageAPI()
    
    /// 0 当前播放的player
    static func currentPlayer()->STPlayer?{
        return STPlayerManage.shareManage.currentPlayer
    }
    
    /// 1 按钮点击操作
    static func playWithURL(_ playUrl : URL, _ configuration : STConfiguration){
        STPlayerManage.shareManage.playWithURL(playUrl, configuration)
    }
    
    /// 2 删除所有
    static func removeAll(){
        STPlayerManage.shareManage.stopUpStPlayer()
        STPlayerManage.shareManage.removeAll()
    }
}
