//
//  DZAccountModel.swift
//  NHDZ
//
//  Created by xiudou on 2018/3/13.
//  Copyright © 2018年 CoderST. All rights reserved.
//

import UIKit

class DZAccountModel: NSObject, NSCoding {
    
    /// 用于调用access_token，接口获取授权后的access token
    var access_token : String = ""
    /// 当前授权用户的UID
    var uid : String = ""
    /// 用户的昵称
    var name : String = ""
    
    // MARK:- 处理需要归档的字段
    func encode(with aCoder:NSCoder){
        aCoder.encode(access_token, forKey:"access_token")
        aCoder.encode(uid, forKey:"uid")
        aCoder.encode(name, forKey:"name")
    }
    
    // MARK:- 处理需要解档的字段
    required init(coder aDecoder:NSCoder) {
        super.init()
        access_token = aDecoder.decodeObject(forKey:"access_token")as?String ?? ""
        uid = aDecoder.decodeObject(forKey:"uid")as?String ?? ""
        name = aDecoder.decodeObject(forKey:"name")as?String ?? ""
        
    }
    
    // 必须要实现
    init(dict : [String : Any]) {
    super.init()
        self.access_token = dict["access_token"] as? String ?? ""
        self.uid = dict["uid"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
    }
}
