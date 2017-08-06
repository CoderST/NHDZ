//
//  STPlayerManage.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/1.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
import SVProgressHUD
class STPlayerManage: NSObject {
    
    /// 单粒管理者
    static let shareManage : STPlayerManage = STPlayerManage()
    /// STPlayer数组
    fileprivate lazy var playerArray : [STPlayer] = [STPlayer]()
    fileprivate var time : Timer?
    
    fileprivate var timeInterval : TimeInterval = 1
    
    /// 正在播放的player
    weak var currentPlayer : STPlayer?
    
    /// 当前播放的图层
    weak var currentPlayerView : STVideoView?
    
    /// 当前播放器的状态
    var status : PlayerState?{
        
        return currentPlayer?.state
    }
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(removeActionPlayer(_:)), name: NSNotification.Name(rawValue: RemoveActionPlayer), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    }

// MARK:- 对外接口
extension STPlayerManage{
    /// 按钮点击操作
     func playWithURL(_ playUrl : URL, _ configuration : STConfiguration){
        
        // 1 是不是活跃状态
        if currentPlayer?.isAction == true && currentPlayerView?.hash == configuration.palyView?.hash{
            // 1.1 是  resume
            currentPlayer?.resume()
            
        }else{
            // 1.2 不是
            // 1.21 停止上个播放
            stopUpStPlayer()
            // 1.22 播放新的视频
            addStPlayer(playUrl, configuration)
        }
        
    }
    
    /// 退出界面删除全部
     func removeAll(){
        removeTime()
        for player in playerArray{
            player.stop()
        }
        SVProgressHUD.dismiss()
        playerArray.removeAll()
    }

// MARK:- 私有方法
    /// 停止上个播放器
     func stopUpStPlayer(){
        guard let currentPlayer = currentPlayer else { return }
        if let index = playerArray.index(of: currentPlayer){
            currentPlayer.isAction = false
            currentPlayer.stop()

            resetVideoView(currentPlayerView)
            
            playerArray.remove(at: index)
        }
    }
    
    /// 添加新的播放器
    fileprivate func addStPlayer(_ playUrl : URL, _ configuration : STConfiguration){
        let player = STPlayer()
        print(player)
        player.isAction = true
        player.playWithURL(playUrl, configuration)
        // 添加新的player
        addPlayer(player)
        currentPlayer = player
        currentPlayerView = configuration.palyView as! STVideoView?
        startTimeAction()

    }
    
    /// 移除活跃的player
    @objc fileprivate func removeActionPlayer(_ notification : Notification){
        guard let willRemoveCell = notification.object as? STCell else { return }
        
//        guard let currentPlayCell = currentPlayerView?.superview as? STCell else { return }
        
        if willRemoveCell.videlView.hash == currentPlayerView?.hash {
            currentPlayer?.stop()
            resetVideoView(currentPlayerView)
            
            deletePlayer(currentPlayer)
            removeTime()
            print("可以移除")
        }else{
            
            print("不需要移除")
        }
    }
    

    
    /// videoView复位
    fileprivate func resetVideoView(_ videoView : UIView?){
        if let viedoView = videoView as? STVideoView{
            viedoView.reset()
        }
    }
    
    @objc fileprivate func startTimeAction(){
        if time == nil {
            time = Timer(timeInterval: timeInterval, target: self, selector: #selector(videoViewUpUI), userInfo: nil, repeats: true)
            RunLoop.main.add(time!, forMode: .commonModes)
            
        }
        
    }
    
    @objc fileprivate func videoViewUpUI() {
        if currentPlayer?.isAction == true {
            guard let currentPlayer = currentPlayer else { return }
            if currentPlayer.state == .Stopped {
                stopUpStPlayer()
            }
            currentPlayerView?.upData(currentPlayer)
        }
    }
    
    fileprivate func removeTime() {
        time?.invalidate()
        time = nil
    }
    
}

// MARK:- 私有方法
extension STPlayerManage {
    
    /// 添加player
    fileprivate func addPlayer(_ player : STPlayer){
        if playerArray.contains(player){
            
            print("已经存在player - ",player)
            
        }else{
            
            playerArray.append(player)
        }
    }
    
    /// 删除player
    fileprivate func deletePlayer(_ player : STPlayer?){
        
        if player == nil {
            
            return
        }
        
        if playerArray.contains(player!) {
            
            guard let index = playerArray.index(of: player!) else {
                
                return
            }
            player?.stop()
            playerArray.remove(at: index)
            
            
        }else{
            
            print("player - 不存在",player!)
        }
    }
    
}
