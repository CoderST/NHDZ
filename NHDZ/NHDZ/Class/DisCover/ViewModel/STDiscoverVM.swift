//
//  STDiscoverVM.swift
//  NHDZ
//
//  Created by xiudou on 2017/8/7.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit

class STDiscoverVM: NSObject {
    
    /// 轮播
    lazy var bannerArray : [Banners] = [Banners]()
    /// 轮播尺寸
    var bannerSize : CGSize = .zero
    /// 分类数组
    lazy var discoverFrameArray : [STDiscoverFrame] = [STDiscoverFrame]()
    
}

extension STDiscoverVM {
    
    func loadCategoryDatas( _ finishCallBack : @escaping ()->(), _ failCallBack : @escaping (_ message : String)->()){
        
        let userInforString = "http://lf.snssdk.com/2/essay/discovery/v3/?iid=11612214903&idfa=99F096BA-477A-4D0A-AB26-69B76DDB85C6&version_code=5.8.0&device_type=iPhone%205%20(Global)&live_sdk_version=130&os_version=8.4&screen_width=640&aid=7&vid=D5CDF3B6-1637-454E-B4BD-5CA1DF31E543&device_id=4598024398&os_api=18&app_name=joke_essay&device_platform=iphone&ac=WIFI&openudid=7881ad6e7d291af91681a760a49f1202e5954292&channel=App%20Store"
        
        NetworkTools.requestData(.get, URLString: userInforString) { (result) -> () in
            guard let resultDict = result as? [String : Any] else { return }
            
            guard let resultMessage = resultDict["message"] as? String else { return }
            
            if resultMessage != "success"{
                failCallBack(resultMessage)
                return
            }
            guard let dict = result as? NSDictionary else { return }
            if let object = STDiscoverMainModel.deserialize(from: dict) {
                
                if let discoverData = object.data{
                    
                    // 取出轮播
                    if let banners = discoverData.rotate_banner?.banners{
                        self.bannerArray = banners
                        let width = banners.first?.banner_url?.width ?? 0
                        let height = banners.first?.banner_url?.height ?? 0
                        self.bannerSize = self.getRanderSize(CGFloat(width), CGFloat(height))
                    }
                    
                    // 取出分类
                    if let categories = discoverData.categories{
                        
                        let categoryList = categories.category_list
                        
                        for category in categoryList{
                            let frame = STDiscoverFrame(category)
                            
                            self.discoverFrameArray.append(frame)
                        }
                    }
                    
                }
                
                finishCallBack()
            }
        }
        
    }
    
    fileprivate func getRanderSize(_ width : CGFloat, _ height : CGFloat)->CGSize{
        
        let resultWidth = sScreenW
        
        let resultHeight = height * resultWidth / width
        
        let size = CGSize(width: resultWidth, height: resultHeight)
        
        return size
    }
}

