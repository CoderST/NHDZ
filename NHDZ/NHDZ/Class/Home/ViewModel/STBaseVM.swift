//
//  STBaseVM.swift
//  NHDZ
//
//  Created by xiudou on 2017/9/25.
//  Copyright © 2017年 CoderST. All rights reserved.
//
/*
 http://log.snssdk.com/service/2/app_log/?iid=11612214903&ac=WIFI&channel=App%20Store&app_name=joke_essay&aid=7&version_code=5.8.0&device_platform=iphone&os_version=8.4&device_type=iPhone%205%20(Global)&device_id=4598024398&vid=D5CDF3B6-1637-454E-B4BD-5CA1DF31E543&openudid=7881ad6e7d291af91681a760a49f1202e5954292&os_api=18&idfa=99F096BA-477A-4D0A-AB26-69B76DDB85C6&screen_width=640
 */
import UIKit
enum timeResultMessage : String {
    case success = "success"
}
class STBaseVM: NSObject {

    // MARK:- 请求最新时间
    class func requestNewestTime(){
        
        let url = "http://log.snssdk.com/service/2/app_log/?iid=11612214903&ac=WIFI&channel=App%20Store&app_name=joke_essay&aid=7&version_code=5.8.0&device_platform=iphone&os_version=8.4&device_type=iPhone%205%20(Global)&device_id=4598024398&vid=D5CDF3B6-1637-454E-B4BD-5CA1DF31E543&openudid=7881ad6e7d291af91681a760a49f1202e5954292&os_api=18&idfa=99F096BA-477A-4D0A-AB26-69B76DDB85C6&screen_width=640"
        let parameters = ["appkey" : APPKEY,
                          "mc" : "02:00:00:00:00:00",
                          "package" : "com.ss.iphone.essay.Joke",
                          "display_name" : "内涵段子"
                          ]
        NetworkTools.requestData(.post, URLString: url,parameters: parameters) { (result) in
            guard let resultDict = result as? [String : Any] else { return }
//            guard let successString = resultDict["message"] as? String else { return }
//            guard let messageType = timeResultMessage.init(rawValue: successString) else { return }
//            if messageType == .success{
                guard let dict = result as? NSDictionary else { return }
                
                if let object = STTimeModel.deserialize(from: dict) {
                    self.userDefaultsTime(object.server_time)
                }

//            }
        }
    }
}

extension STBaseVM{
    /// 存时间
    class func userDefaultsTime(_ serverTime : Int){
        STNSUserDefaults.set(serverTime, forKey: timeModelTime)
        STNSUserDefaults.synchronize()
    }
    
    /// 取时间
    class func getUserDefaultsTime()->Int{
        guard let time = STNSUserDefaults.object(forKey: timeModelTime) as? Int else { return 0 }
        return time
    }
}

extension STBaseVM{
    // 获取最终服务时间
    class func getSeverTime()->Int{
        let userDefaultsTime = getUserDefaultsTime()
        let moveTime = Int(STTimeManage.shareInstance.timeInterval)
        let resultTime = userDefaultsTime + moveTime
        return resultTime
    }
}
