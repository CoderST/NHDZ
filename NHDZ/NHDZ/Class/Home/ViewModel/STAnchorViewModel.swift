//
//  STAnchorViewModel.swift
//  NHDZ
//
//  Created by xiudou on 2017/8/16.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit

class STAnchorViewModel: NSObject {
    lazy var anchorFramelist : [STAnchorModelFrame] = [STAnchorModelFrame]()
    func getRoomAnchorData(_ page : Int,finishCallBack : @escaping ()->(),noDataCallBack:@escaping ()->()){
        
        let urlS = "http://live.9158.com/Fans/GetHotLive?page="
        // 此处用的是YK/MB的链接
        let urlString = urlS + String(page)
        print(urlString)
        NetworkTools.requestData(.get ,URLString: urlString, parameters: nil) { (result) -> () in
            
            
            guard let resultDict = result as? [String : Any] else { return }
            
            guard let resultMessage = resultDict["msg"] as? String else { return }
            
            if resultMessage != "操作成功"{
                //                failCallBack(resultMessage)
                return
            }
            guard let dict = result as? NSDictionary else { return }
            if let object = STAnchorMainModel.deserialize(from: dict){
                guard let data = object.data else { return }
                for anchor in data.list{
                    let anchorFrame = STAnchorModelFrame(anchor)
                    self.anchorFramelist.append(anchorFrame)
                }
            }
            finishCallBack()
        }
        
    }
}
