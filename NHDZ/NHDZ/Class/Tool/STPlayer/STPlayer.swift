//
//  STPlayer.swift
//  STPlayerExample
//
//  Created by xiudou on 2017/1/24.
//  Copyright © 2017年 CoderST. All rights reserved.
//  播放器

import UIKit
import SVProgressHUD
import MediaPlayer

let kPlayerURLOrStateChangeNotification = "playerURLOrStateChangeNotification"
enum PlayerState{
    /// 不明
    case UnKnow
    /// 加载...
    case Loading
    /// 播放...
    case Playing
    /// 停止
    case Stopped
    /// 暂停
    case Pause
    /// 失败
    case Failed
}

class STPlayer: NSObject {
    // MARK:- 懒加载
        
    // MARK:- 创建单粒
    //    static let shareInstance : STPlayer = STPlayer()
    
    fileprivate lazy var reourceLoaderManager : STReourceLoaderManager = STReourceLoaderManager()
    
    fileprivate var player : AVPlayer?
    fileprivate var playerLayer : AVPlayerLayer?
    // MARK:- 变量
    /// 配置
    fileprivate var configuration : STConfiguration!
    /// 是否为活跃状态
    var isAction : Bool = false
    
    /// 是否自动播放
    var isAutoPlay : Bool = false
    var callBack : ((_ playerLayer : AVPlayerLayer) -> ())?
    var totalTimeString : String = ""
    // 外部
    /// 音频总时长
    var durationTime : TimeInterval{
        get{
            
            guard let totalTime = player?.currentItem?.duration else { return 0}
            // 当前播放到的时间
            let totalTimeSec = CMTimeGetSeconds(totalTime)
            if totalTimeSec.isNaN == true{
                return 0
            }
            return totalTimeSec
            
        }
    }
    /// 音频当前播放时长
    var currentTime : TimeInterval{
        
        get{
            guard let currentTime = player?.currentItem?.currentTime() else { return 0}
            // 当前播放到的时间
            let currentTimeSec = CMTimeGetSeconds(currentTime)
            if currentTimeSec.isNaN == true{
                return 0
            }
            return currentTimeSec
            
        }
    }
    /// 播放进度, 可以反向设置
    var progress : Float{
        
        get{
            if durationTime == 0 || currentTime == 0{
                return 0
            }
            return Float(currentTime) / Float(durationTime)
            
        }
    }
    /// 缓冲进度 // 注意: 播放器, 本身就附带, 边播放, 边下载的功能, 但是, 缓存到的是内存中, 没有磁盘缓存
    var loadProgress : Float{
        get{
            if durationTime == 0{
                return 0
            }
            guard let timeRange = player?.currentItem?.loadedTimeRanges.first?.timeRangeValue else { return 0 }
            let loadTime = CMTimeAdd(timeRange.start, timeRange.duration)
            let loadTimeSec = CMTimeGetSeconds(loadTime)
            return Float(loadTimeSec) / Float(durationTime)
            
        }
    }
    /// 音频URL地址
    var url : URL?{
        didSet{
            guard let url = url else { return }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPlayerURLOrStateChangeNotification), object: nil, userInfo: ["state": state , "url": url])
        }
    }
    /// 是否静音
    var muted : Bool?{
        
        didSet{
            player?.isMuted = muted ?? false
        }
    }
    /// 音量大小
    var volume : Float = 0{
        didSet{
            if volume > 0{
                muted = false
            }
            player?.volume = volume
        }
    }
    
    /// 当前播放状态
    var state : PlayerState = .Pause{
        didSet{
//            guard let url = url else { return }
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPlayerURLOrStateChangeNotification), object: nil, userInfo: ["state": state , "url": url])
            switch state {
            case .Loading:
                SVProgressHUD.show(withStatus: "加载中....")
            default:
                SVProgressHUD.dismiss()
            }
        }
    }
    /// 速率 0.5 1.0 2.0
    var rate : Float?{
        
        didSet{
            player?.rate = rate ?? 1.0
        }
    }
    
    // 内部
    /// 记录用户行为
    fileprivate var isUserPause : Bool = false
    
    
    deinit {
        
        /// 1 清除监听
        clearObserver()
        
        /// 2 停止下载代理
        reourceLoaderManager.stopAndClear()
        
        /// 3 停止播放
        stop()
        
        print("STPlayer-释放")
    }
    
}
// MARK:- 自定义方法
extension STPlayer {
 
    
    // 当前音频资源总时长
    fileprivate func totleTime()->Float{
        
        // 总时间
        guard let totalTime = player?.currentItem?.duration else { return 0}
        // 当前播放到的时间
        let totalTimeSec = CMTimeGetSeconds(totalTime)
        if totalTimeSec.isNaN == true{
            return 0
        }
        return Float(totalTimeSec)
    }
    
    // 当前音频资源总时长 格式化 - 01 : 25
    func totalTimeFormat()->String{
        
        return  String(format: "%02zd:%02zd",Int(totleTime()) / 60, Int(totleTime()) % 60)
    }
    
    // 当前音频播放时长 格式化 - 01 : 25
    func currentTimeFormat()->String {
        
        return  String(format: "%02zd:%02zd",Int(currentTime) / 60, Int(currentTime) % 60)
    }
}



// MARK:- 对外接口
extension STPlayer {
    /*
     playUrl : 播放的URL
     playView : 需要展示图像层的View
     isCache : 是否需要缓存 默认为false
     */
    func playWithURL(_ playUrl : URL, _ configuration : STConfiguration){
                self.configuration = configuration
        if let urlAsset = player?.currentItem?.asset as? AVURLAsset {
            // 同一个URL地址
            if playUrl == urlAsset.url || playUrl.streamingURL() == urlAsset.url {
                print("已经存在当前播放任务")
                resume()
                return
            }
        }
        
        if player?.currentItem != nil{
            clearObserver()
        }
        
        url = playUrl
        if configuration.isCache == true{
            url = playUrl.streamingURL()
        }
        
        
        // 0 守护URL
        guard let url = url else { return }
        // 1 资源请求
        let asset = AVAsset(url: url)
        guard let urlAsset = asset as? AVURLAsset else { return }
        // 2 拦截代理方法
        urlAsset.resourceLoader.setDelegate(reourceLoaderManager, queue: DispatchQueue.main)
        // 3 资源的组织
        let playItem = AVPlayerItem(asset: asset)
//        clearObserver()
        // 4 当资源的组织者, 告诉资源准备好了之后, 再播放
        // 5 利用KVO 监听状态的改变
        playItem.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        playItem.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: nil)
        playItem.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
        
        // 6 监听通知
        NotificationCenter.default.addObserver(self, selector: #selector(playEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(audioPlayInterrupt), name: NSNotification.Name.AVPlayerItemPlaybackStalled, object: nil)
        
        // 7 资源的播放
        player = AVPlayer(playerItem: playItem)
        
        // 判断是否带播放画面
        if configuration.palyView != nil {
            let playView = configuration.palyView!
            // 1 创建AVPlayerLayer
            let playerLayer = AVPlayerLayer(player: player)
            self.playerLayer = playerLayer
            // 2 设置画面缩放模式  AVLayerVideoGravityResizeAspectFill
            playerLayer.videoGravity = AVLayerVideoGravityResizeAspect
            
            // 3 设置播放页面大小
            let rect  = configuration.playerLayerF
            playerLayer.frame = playView.bounds
            print("playerLayer.bounds = ",playerLayer.frame)
            // 4 playerLayer添加到显示图层
            
            // 位置放在最底下
            playView.layer.insertSublayer(playerLayer, at: 0)
            
        }
        
    }
    
    
    // 继续
    func resume() {
        isUserPause = false
        player?.play()
        if player != nil && player?.currentItem?.isPlaybackLikelyToKeepUp == true{
            state = .Playing
        }else{
            
            if player != nil{
                state = .Loading
            }else{
                state = .UnKnow
            }
        }
    }
    // 暂停
    func pause() {
        isUserPause = true
        player?.pause()
        if player != nil {
            state = .Pause
        }
    }
    // 停止
    func stop() {
        url = nil
        reourceLoaderManager.stopAndClear()
        clearObserver()
        player?.pause()
        player = nil
        state = .Stopped
    }
    
   
    func playComplet(){
        clearObserver()
        player?.pause()
        state = .Pause
    }
    
    // 根据时间差, 完成快进10秒, 或者快退10秒的操作
    func seekWithTimeDiffer(timeDiffer : TimeInterval){
        // 1. 当前音频资源的总时长
        let totalTimeSec = durationTime
        // 2. 当前音频, 已经播放的时长
        
        var playTimeSec = currentTime
        playTimeSec += timeDiffer;
        seekWithProgress(Float(playTimeSec) / Float(totalTimeSec))
    }
    
    
}

extension STPlayer {
    
    func seekWithProgress(_ progress : Float){
        if progress < 0 || progress > 1{
            
            return
        }
        guard let totleTime = player?.currentItem?.duration else { return }
        let totalSec = CMTimeGetSeconds(totleTime)
        let playTimeSec = Float(totalSec) * progress
        let currentTime = CMTimeMake(Int64(playTimeSec), 1)
        player?.seek(to: currentTime, completionHandler: { (finished) in
            if finished{
                print("确定加载这个时间点的音频资源")
            }else{
                print("取消加载这个时间点的音频资源")
            }
        })
    }
}

// MARK:- 内部方法
extension STPlayer {
    
    // 清楚所有监听
    fileprivate func clearObserver() {
        player?.currentItem?.removeObserver(self, forKeyPath: "status")
        player?.currentItem?.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp")
        player?.currentItem?.removeObserver(self, forKeyPath: "playbackBufferEmpty")
        NotificationCenter.default.removeObserver(self)
        
    }
    
    // 清楚所有监听
//    fileprivate func clearTime() {
//        time?.invalidate()
//        time = nil
//    }
//    
    // KVO监听
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        
        let playItem:AVPlayerItem = object as! AVPlayerItem
        if keyPath == "status" {
            
            if playItem.status == AVPlayerItemStatus.failed {
                let error = playItem.error
                print(error ?? "-------------")
                return
            }
        }
        
        if keyPath == "status"{ //status 有三种状态
            guard let statusIndex = change?[NSKeyValueChangeKey.newKey] as? Int else  { return }
            guard let status = AVPlayerItemStatus(rawValue: statusIndex) else { return }
            switch status {
            case .readyToPlay:
                resume()
                print("准备成功")
            case .failed:
                state = .Failed
                print("准备失败")
            default:
                state = .UnKnow
                print("未知状态")
            }
            
        }else if keyPath == "playbackLikelyToKeepUp"{      // 缓冲达到可播放程度了
            guard let playbackLikelyToKeepUp = change?[.newKey] as? Bool else { return }
            if playbackLikelyToKeepUp == true{
                
                if isUserPause == false{
                    print("资源充足,可以播放")
                    resume()
                }
            }else{
                
                state = .Loading
                print("资源不足,正在加载中...")
            }
        }else if keyPath == "playbackBufferEmpty"{ // 监听播放器在缓冲数据的状态
            guard let isBufferEmpty = change?[.newKey] as? Bool else { return }
            if isBufferEmpty == true {
                print("缓冲区空了,正在加载...")
                state = .Loading
            }
            
        }
    }
    
    @objc fileprivate func playEnd() {
        print("播放结束")
        state = .Stopped
    }
    
    @objc fileprivate func audioPlayInterrupt() {
        print("播放被打算")
        state = .Failed
    }
}
