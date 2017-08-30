//
//  STRefreshGifHeader.swift
//  NHDZ
//
//  Created by xiudou on 2017/8/15.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
import MJRefresh
class STRefreshGifHeader: MJRefreshGifHeader {

    override func prepare() {
        super.prepare()
        lastUpdatedTimeLabel?.isHidden = true
        stateLabel?.isHidden = true
        // 设置普通状态的动画图片
        var idleImages : [UIImage] = [UIImage]()
        for i in 0..<2{
            let imageName = String(format: "refresh_head_%zd",i)
            guard let image = UIImage(named: imageName) else { continue }
            idleImages.append(image)
        }
        setImages(idleImages, for: .idle)
        
//        var pullImages : [UIImage] = [UIImage]()
        let imageName = String(format: "refresh_head_1")
        if let image = UIImage(named: imageName){
            setImages([image], for: .pulling)
        }
        
        
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        var refreshingImages : [UIImage] = [UIImage]()
        for i in 0..<2{
            let imageName = String(format: "refresh_head_loading_%zd",i)
            guard let image = UIImage(named: imageName) else { continue }
            refreshingImages.append(image)
        }
        
        // 设置正在刷新状态的动画图片
//        setImages(refreshingImages, for: .refreshing)
        setImages(refreshingImages, duration: 1.0, for: .refreshing)
    }

}
