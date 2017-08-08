//
//  STVideoView.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/7/29.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
//import SDWebImage
import SVProgressHUD
import Kingfisher
import AVFoundation
fileprivate let toolBarViewHeight : CGFloat = 40

class STVideoView: UIView {
    
//    var playerManage = STPlayerManage.shareManage
    
    fileprivate lazy var burImageView : UIImageView = {
        
        let burImageView = UIImageView()
        return burImageView
    }()
    
    /// 工具条View
    fileprivate lazy var toolBarView: UIView = {
        let toolBarView = UIView()
        toolBarView.backgroundColor = UIColor(red: 245.0 / 255.0, green: 245.0 / 255.0, blue: 245.0 / 255.0, alpha: 0.5)
        return toolBarView
    }()
    
    /// 暂停\开始
     lazy var pauseOrResumeButton: UIButton = {
        let pauseOrResumeButton = UIButton()
        pauseOrResumeButton.backgroundColor = .red
        pauseOrResumeButton.setTitle("开始", for: .normal)
        pauseOrResumeButton.setTitle("暂停", for: .selected)
        return pauseOrResumeButton
    }()
    
    /// 暂停\开始
    fileprivate lazy var pauseOrResumeCenterButton: UIButton = {
        let pauseOrResumeCenterButton = UIButton()
        pauseOrResumeCenterButton.backgroundColor = .red
        pauseOrResumeCenterButton.setTitle("开始", for: .normal)
        pauseOrResumeCenterButton.setTitle("暂停", for: .selected)
        return pauseOrResumeCenterButton
    }()
    
    /// 开始播放时间
    fileprivate lazy var startTimeLabel: UILabel = {
        let startTimeLabel = UILabel()
        startTimeLabel.text = "00:00"
        startTimeLabel.textAlignment = .center
        return startTimeLabel
    }()
    
    /// 总共播放时间
    fileprivate lazy var totleTimeLabel: UILabel = {
        let totleTimeLabel = UILabel()
        totleTimeLabel.text = "00:00"
        totleTimeLabel.textAlignment = .center
        return totleTimeLabel
    }()
    
    /// 是否静音
    fileprivate lazy var isJingYinButton: UIButton = {
        let isJingYinButton = UIButton()
        isJingYinButton.backgroundColor = .orange
        isJingYinButton.setTitle("静音", for: .normal)
        isJingYinButton.setTitle("关闭", for: .selected)
        return isJingYinButton
    }()
    
    /// 音量
    fileprivate lazy var yinLiangSlider: UISlider = {
        let yinLiangSlider = UISlider()
        return yinLiangSlider
    }()
    
    /// 播放进度
    fileprivate lazy var playProgressSlider: UISlider = {
        let playProgressSlider = UISlider()
        playProgressSlider.maximumTrackTintColor = UIColor(white: 0.8, alpha: 0.5)
        playProgressSlider.value = 0
        return playProgressSlider
    }()
    
    /// 加载进度
    fileprivate lazy var loadProgressView: UIProgressView = {
        let loadProgressView = UIProgressView(progressViewStyle: .bar)
        return loadProgressView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 添加子空间
        addSubViews()
        
        // 添加点击事件
        addClickAction()
        
        // 设置系统音量
        systemVolume()
        
        
    }
    
    var connotationModelFrame : STConnotationModelFrame?{
        
        didSet{
            guard let connotationModelFrame = connotationModelFrame else { return }
            
            setupBurImage(connotationModelFrame)
            
            showTotalTIme(connotationModelFrame)
        }
    }
    
    
    
    deinit {
        stop()
        STPlayerManage.shareManage.currentPlayer?.stop()
        print("STVideoView - 销毁")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 对外接口
extension STVideoView{
    // 清除
    func stop() {
        NotificationCenter.default.removeObserver(self)
        UIApplication.shared.endReceivingRemoteControlEvents()
        
    }
    
    /// 复位
    func reset(){
        removePlayerLay()
        pauseOrResumeButton.isSelected = false
        insertSubview(burImageView, belowSubview: toolBarView)
        // 播放进度
        playProgressSlider.value = 0
        // 开始时间
        startTimeLabel.text = "00:00"
//        // 总时间
//        totleTimeLabel.text = playerManage.playeringModel?.totalTimeFormat()
    }
    
    fileprivate func removePlayerLay(){
        guard let sublayers = layer.sublayers else { return }
        if sublayers.count > 0{
            
            for sublayer in sublayers{
                if sublayer is AVPlayerLayer {
                    sublayer.removeFromSuperlayer()
                }
            }
        }
    }

//    fileprivate func playCompletAction(){
//        time?.invalidate()
//        time = nil
//        pauseOrResumeButton.isSelected = false
//    }
}

// MARK:- 点击拖动事件
extension STVideoView {
    
    @objc fileprivate func pauseOrResumeButtonClick(_ sender : UIButton) {
            if sender.isSelected == false{
                sender.isSelected = true
                guard let connotationModelFrame = connotationModelFrame else { return }
                
                guard let url = URL(string: connotationModelFrame.videoString) else { return }
                let cachePath = STFileManager.getFileCachePath(url: url)
                print(cachePath)
                SVProgressHUD.show(withStatus: "加载中....")
                let config = STConfiguration()
                config.isCache = false
                config.palyView = self
                config.playerLayerF = connotationModelFrame.videoFrame
                STPlayerManageAPI.playWithURL(url, config)
                insertSubview(burImageView, at: 0)
                
                
            }else{
                sender.isSelected = false
//                print(STPlayerManageAPI.currentPlayer())
                
                STPlayerManageAPI.currentPlayer()?.pause()
            }
    }
    
    // 播放进度
    func playProgressSliderAction(_ sender: UISlider) {
        STPlayerManageAPI.currentPlayer()?.seekWithProgress(sender.value)
    }
    
    // 是否静音
    func isJIngYinClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        STPlayerManageAPI.currentPlayer()?.muted = sender.isSelected
        if STPlayerManageAPI.currentPlayer()?.muted == true{
            yinLiangSlider.value = 0
        }else{
            do{
                try AVAudioSession.sharedInstance().setActive(true)
            }catch let error as NSError{
                print("\(error)")
            }
            
            //获取并赋值
            yinLiangSlider.value = AVAudioSession.sharedInstance().outputVolume
        }
    }
    
    // 音量大小
    @IBAction func yinLiangSliderAction(_ sender: UISlider) {
        STPlayerManageAPI.currentPlayer()?.volume = sender.value
        if sender.value > 0 {
            isJingYinButton.isSelected = false
        }else{
            isJingYinButton.isSelected = true
        }
    }
    
}

// MARK:- 设置尺寸
extension STVideoView {
    
    fileprivate func setupToolBarSubViewFrame(_ connotationModelFrame : STConnotationModelFrame){
        let videoWidth = connotationModelFrame.videoFrame.width
        let videoHeight = connotationModelFrame.videoFrame.height
        let margin : CGFloat = 10
        let toolBarViewWidth : CGFloat = videoWidth
        toolBarView.frame = CGRect(x: 0, y: videoHeight - toolBarViewHeight, width: toolBarViewWidth, height: toolBarViewHeight)
        
        // 播放暂停
        pauseOrResumeButton.sizeToFit()
        pauseOrResumeButton.frame = CGRect(x: margin, y: 0, width: pauseOrResumeButton.frame.width, height: toolBarViewHeight)
        pauseOrResumeCenterButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        pauseOrResumeCenterButton.center = CGPoint(x: videoWidth * 0.5, y: videoHeight * 0.5)
        //        print("pauseOrResumeButton = ",pauseOrResumeButton.frame)
        
        // 开始时间
        startTimeLabel.sizeToFit()
        startTimeLabel.frame = CGRect(x: pauseOrResumeButton.frame.maxX + margin, y: 0, width: startTimeLabel.frame.width + 5, height: toolBarViewHeight)
        
        // 总共时间
        totleTimeLabel.sizeToFit()
        let totleTimeLabelW : CGFloat = totleTimeLabel.frame.width + 5
        totleTimeLabel.frame = CGRect(x: toolBarViewWidth - totleTimeLabelW - margin, y: 0, width: totleTimeLabelW, height: toolBarViewHeight)
        
        // 播放进度
        let playProgressSliderX = startTimeLabel.frame.maxX + margin
        let playProgressSliderW = totleTimeLabel.frame.origin.x - margin - playProgressSliderX
        playProgressSlider.frame = CGRect(x: startTimeLabel.frame.maxX + margin, y: 0, width: playProgressSliderW, height: toolBarViewHeight)
        
        // 加载进度
        loadProgressView.frame = playProgressSlider.frame
        loadProgressView.center = playProgressSlider.center
        
        // 音量
        //        yinLiangSlider.transform = CGAffineTransformMakeRotation( M_PI * 0.5 )
        yinLiangSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI * 0.5))
        let yinLiangSliderW : CGFloat = 80
        let yinLiangSliderH : CGFloat = 80
        yinLiangSlider.frame = CGRect(x: 0, y: 50, width: yinLiangSliderW, height: yinLiangSliderH)
        
        // 是否静音
        isJingYinButton.sizeToFit()
        let isJingYinButtonW : CGFloat = isJingYinButton.frame.width
        let isJingYinButtonH : CGFloat = isJingYinButton.frame.height
        isJingYinButton.frame = CGRect(x: videoWidth - isJingYinButtonW - margin, y: videoHeight - isJingYinButtonH - margin - toolBarViewHeight, width: isJingYinButtonW, height: isJingYinButtonH)
    }
    
    
    
}

// MARK:- 私有方法
extension STVideoView {
    
    fileprivate func setupBurImage(_ connotationModelFrame : STConnotationModelFrame){
        burImageView.frame = CGRect(x: 0, y: 0, width: sScreenW, height: connotationModelFrame.videoFrame.height)
        setupToolBarSubViewFrame(connotationModelFrame)
        
        
        let videoPlaceHoldString = connotationModelFrame.videoPlaceHoldString
        let url = URL(string: videoPlaceHoldString)
        let image = UIImage(named: "")
        burImageView.kf.setImage(with: url, placeholder: UIImage(named: "timeline_image_placeholder"), options: nil, progressBlock: { (receivedSize, expectedSize) in
            
        }) { (image, error, cacheType, imageUrl) in
            if image != nil{
                
                let burImage = UIImage.boxBlurImage(image!, withBlurNumber: 0.5)
                self.burImageView.image = burImage
            }

        }
    }
    
    fileprivate func showTotalTIme(_ connotationModelFrame : STConnotationModelFrame) {
        // 显示总时长
        let timeString = String.timeFormatted(connotationModelFrame.videoPlayTime)
        totleTimeLabel.text = timeString
        
    }
    
    fileprivate func addSubViews(){
        addSubview(burImageView)
        addSubview(toolBarView)
        addSubview(isJingYinButton)
        addSubview(yinLiangSlider)
        toolBarView.addSubview(pauseOrResumeButton)
        toolBarView.addSubview(startTimeLabel)
        toolBarView.addSubview(totleTimeLabel)
        toolBarView.addSubview(loadProgressView)
        toolBarView.addSubview(playProgressSlider)
        
    }
    
    @objc fileprivate func addClickAction(){
        pauseOrResumeButton.addTarget(self, action: #selector(pauseOrResumeButtonClick(_:)), for: .touchUpInside)
        yinLiangSlider.addTarget(self, action: #selector(yinLiangSliderAction(_:)), for: .touchUpInside)
        playProgressSlider.addTarget(self, action: #selector(playProgressSliderAction(_:)), for: .valueChanged)
        isJingYinButton.addTarget(self, action: #selector(isJIngYinClick(_:)), for: .touchUpInside)
    }
    
    @objc fileprivate func systemVolume(){
        
        do{
            try AVAudioSession.sharedInstance().setActive(true)
        }catch let error as NSError{
            print("\(error)")
        }
        
        //获取并赋值
//        print(AVAudioSession.sharedInstance().outputVolume)
        yinLiangSlider.value = AVAudioSession.sharedInstance().outputVolume
        //添加监听
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeVolumSlider), name: NSNotification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
        //        NotificationCenter.default.addObserver(self, selector: "changeVolumSlider", name: AVSystemController_SystemVolumeDidChangeNotification, object: nil)
        UIApplication.shared.beginReceivingRemoteControlEvents()
    }
    
    @objc fileprivate func changeVolumSlider(notifi : NSNotification) {
        if let volum : Float = notifi.userInfo?["AVSystemController_AudioVolumeNotificationParameter"] as! Float?{
            yinLiangSlider.value = volum
        }
    }
    
}

extension STVideoView {
    
    func upData(_ currentPlayer : STPlayer) {
        
        let status = currentPlayer.state
        switch status {
        case .Failed:
            print("upData-failed")
            pauseOrResumeButton.isSelected = false
        case .Loading:
            print("upData-Loading")
//            pauseOrResumeButton.isSelected = false
        case .Pause:
            print("upData-Pause")
//            pauseOrResumeButton.isSelected = false
        case .Playing:
            print("upData-Playing")
            pauseOrResumeButton.isSelected = true
            // 下载进度
            loadProgressView.progress = currentPlayer.loadProgress
            // 播放进度
            playProgressSlider.value = currentPlayer.progress
            // 开始时间
            //            print("startTimeLabel = ",playerManage.playeringModel?.currentTimeFormat())
            startTimeLabel.text = currentPlayer.currentTimeFormat()
        case .Stopped:
            reset()
            print("upData-Stopped")
            pauseOrResumeButton.isSelected = false
            startTimeLabel.text = "00:00"
        case .UnKnow:
            print("upData-UnKnow")
        default:
            print("-------")
        }
    }

}


