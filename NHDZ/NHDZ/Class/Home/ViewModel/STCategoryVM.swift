//
//  STCategoryVM.swift
//  NHDZ
//
//  Created by xiudou on 2017/8/7.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit

class STCategoryVM: NSObject {
    
    lazy var connotationModelFrameArray : [STConnotationModelFrame] = [STConnotationModelFrame]()
    
    func loadCategoryDatas(_ category_id : Int, _ finishCallBack : @escaping ()->(), _ failCallBack : @escaping (_ message : String)->()){
        
        let userInforString = "http://lf.snssdk.com/neihan/stream/category/data/v2/?tag=joke&iid=11612214903&idfa=99F096BA-477A-4D0A-AB26-69B76DDB85C6&version_code=5.8.0&device_type=iPhone%205%20(Global)&live_sdk_version=130&os_version=8.4&screen_width=640&aid=7&vid=D5CDF3B6-1637-454E-B4BD-5CA1DF31E543&device_id=4598024398&os_api=18&app_name=joke_essay&device_platform=iphone&ac=WIFI&openudid=7881ad6e7d291af91681a760a49f1202e5954292&channel=App%20Store&category_id=\(category_id)&count=30&level=6&message_cursor=0&mpic=1"
        
        NetworkTools.requestData(.get, URLString: userInforString) { (result) -> () in
            guard let resultDict = result as? [String : Any] else { return }
            
            guard let resultMessage = resultDict["message"] as? String else { return }
            
            if resultMessage != "success"{
                failCallBack(resultMessage)
                return
            }
            guard let dict = result as? NSDictionary else { return }
            if let object = STCategoryMainModel.deserialize(from: dict) {
                
                if let bigData = object.data{
                    
                let contentAndCommentArray = bigData.data
                        
                    for contentAndComment in contentAndCommentArray
                    {
                        let contentAndCommentFrame = STConnotationModelFrame(contentAndComment)
                        self.connotationModelFrameArray.append(contentAndCommentFrame)
                    }
                    
                    finishCallBack()
                }
            }
            
        }
    }
}
