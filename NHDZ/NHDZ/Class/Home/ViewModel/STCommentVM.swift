//
//  STCommentVM.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/4.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit

class STCommentVM: NSObject {

    lazy var userInforModel : STCommentUserInforModel = STCommentUserInforModel()
    var adModelFrame : STCommentADModelFrame?
    var diggUsersModelFrame : STCommentDiggUsersModelFrame?
    
    var commentSectionDatas : [STCommentGroup] = [STCommentGroup]()
    fileprivate lazy var hotCommetGroup : STCommentGroup = STCommentGroup()
    fileprivate lazy var fishCommetGroup : STCommentGroup = STCommentGroup()

//    lazy var commentModel : STCommentModel = STCommentModel()
    
    /*
     userID : 用户ID
     group_id : 组ID
     */
    func loadUserAndDiggUsersAndComments(_ userID : String, group_id :String, _ finishCallBack : @escaping ()->(), _ failCallBack : @escaping (_ message : String)->()){
        let group = DispatchGroup()
        group.enter()
        // 用户信息
        let userInforString = "http://isub.snssdk.com/neihan/user/profile/v2/?version_code=5.8.0&user_id=\(userID)"
        NetworkTools.requestData(.get, URLString: userInforString) { (result) -> () in
            guard let resultDict = result as? [String : Any] else { return }
            
            guard let resultMessage = resultDict["message"] as? String else { return }
            
            if resultMessage != "success"{
                failCallBack(resultMessage)
                return
            }
            guard let dict = result as? NSDictionary else { return }
            if let object = STCommentUserInforModel.deserialize(from: dict) {
                self.userInforModel = object
            }
            group.leave()
            
        }
        
        // 广告
        group.enter()
        let adUrlString = "http://lf.snssdk.com/service/14/essay_text_link_ad/?iid=11612214903&idfa=99F096BA-477A-4D0A-AB26-69B76DDB85C6&version_code=5.8.0&device_type=iPhone%205%20(Global)&live_sdk_version=130&os_version=8.4&screen_width=640&aid=7&vid=D5CDF3B6-1637-454E-B4BD-5CA1DF31E543&device_id=4598024398&os_api=18&app_name=joke_essay&device_platform=iphone&ac=WIFI&openudid=7881ad6e7d291af91681a760a49f1202e5954292&channel=App%20Store&daymode=1&isvideo=0&text_only=0"
        NetworkTools.requestData(.get, URLString: adUrlString) { (result) -> () in
            guard let resultDict = result as? [String : Any] else { return }
            
            guard let resultMessage = resultDict["message"] as? String else { return }
            
            if resultMessage != "success"{
                failCallBack(resultMessage)
                return
            }
            guard let dict = result as? NSDictionary else { return }
            if let object = STCommentADModel.deserialize(from: dict) {
                self.adModelFrame = STCommentADModelFrame(object)
            }
            group.leave()
            
        }
        
        
        // 赞用户
        let diggUsersUrlString = "http://lf.snssdk.com/neihan/action/digg_users/?iid=11612214903&idfa=99F096BA-477A-4D0A-AB26-69B76DDB85C6&version_code=5.8.0&device_type=iPhone%205%20(Global)&live_sdk_version=130&os_version=8.4&screen_width=640&aid=7&vid=D5CDF3B6-1637-454E-B4BD-5CA1DF31E543&device_id=4598024398&os_api=18&app_name=joke_essay&device_platform=iphone&ac=WIFI&openudid=7881ad6e7d291af91681a760a49f1202e5954292&channel=App%20Store&id=\(group_id)"
        
        group.enter()
        NetworkTools.requestData(.get, URLString: diggUsersUrlString) { (result) -> () in
            guard let resultDict = result as? [String : Any] else { return }
            
            guard let resultMessage = resultDict["message"] as? String else { return }
            
            if resultMessage != "success"{
                failCallBack(resultMessage)
                return
            }
            guard let dict = result as? NSDictionary else { return }
            if let object = STCommentDiggUsersModel.deserialize(from: dict) {
//                self.diggUsersModel = object
                self.diggUsersModelFrame = STCommentDiggUsersModelFrame(object)
            }
            group.leave()
            
        }
      
        // 评论
        group.enter()
        let commentUrlString = "http://isub.snssdk.com/neihan/comments/?iid=11612214903&idfa=99F096BA-477A-4D0A-AB26-69B76DDB85C6&version_code=5.8.0&device_type=iPhone%205%20(Global)&live_sdk_version=130&os_version=8.4&screen_width=640&aid=7&vid=D5CDF3B6-1637-454E-B4BD-5CA1DF31E543&device_id=4598024398&os_api=18&app_name=joke_essay&device_platform=iphone&ac=WIFI&openudid=7881ad6e7d291af91681a760a49f1202e5954292&channel=App%20Store&count=20&device_id=4598024398&group_id=\(group_id)&offset=0&sort=hot&tag=joke"
        NetworkTools.requestData(.get, URLString: commentUrlString) { (result) -> () in
            
            guard let resultDict = result as? [String : Any] else { return }
            
            guard let resultMessage = resultDict["message"] as? String else { return }
            
            if resultMessage != "success"{
                failCallBack(resultMessage)
                return
            }
            guard let dict = result as? NSDictionary else { return }
            if let object = STCommentBigModel.deserialize(from: dict) {
                
                guard let data = object.data else { return }

                if data.top_comments != nil &&  data.top_comments!.count > 0{
                    let topComments = data.top_comments!
                    
                    
                    for comment in topComments{
                        
                        let commentFrame = STCommentModelFrame(comment)
                        self.hotCommetGroup.commentSectionModelFrame.append(commentFrame)
                    }
                    let count = self.hotCommetGroup.commentSectionModelFrame.count
                    self.hotCommetGroup.sectionTitle = "热门评论 (\(count))"
                }
                
                if data.recent_comments != nil &&  data.recent_comments!.count > 0{
                    let recent_comments = data.recent_comments!
                    
                    for comment in recent_comments{
                        
                        let commentFrame = STCommentModelFrame(comment)
                        
                        self.fishCommetGroup.commentSectionModelFrame.append(commentFrame)
                    }
                    let count = self.fishCommetGroup.commentSectionModelFrame.count
                    self.fishCommetGroup.sectionTitle = "新鲜评论 (\(count))"
                }
                
                self.commentSectionDatas = [self.hotCommetGroup,self.fishCommetGroup]
            }
            
            group.leave()
            
        }

        // 对数据进行排序
        group.notify(queue: DispatchQueue.main) { () -> Void in
//            self.anchorGroups.insert(self.prettyGroup, at: 0)
//            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallBack()
        }

    }
}
