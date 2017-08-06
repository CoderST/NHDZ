//
//  STCommentDiggUsersModel.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/4.
//  Copyright © 2017年 CoderST. All rights reserved.
//  点赞用户

import UIKit
import HandyJSON
class STCommentDiggUsersModel: HandyJSON {

    var message: String = ""
    
    var data: DiggUser?
    required init() {}
}
class DiggUser: HandyJSON {
    
    var users: [Users]?
    required init() {}
}

class Users: HandyJSON {
    
    var large_avatar_url: String?
    
    var user_id: Int = 0
    
    var create_time: Int = 0
    
    var repin_count: Int = 0
    
    var new_followers: Int = 0
    
    var user_verified: Bool = false
    
    var city: String = ""
    
    var notification_count: Int = 0
    
    var name: String = ""
    
    var screen_name: String = ""
    
    var avatar_url: String = ""
    
    var followers: Int = 0
    
    var ugc_count: Int = 0
    
    var ID: Int = 0
    
    var gender: Int = 0
    
    var subscribe_count: Int = 0
    
    var point: Int = 0
    
    var followings: Int = 0
    
    var is_pro_user: Bool = false
    
    var is_following: Bool = false
    
    var pro_user_desc: String = ""
    
    var is_follower: Bool = false
    
    var comment_count: Int = 0
    
    var description: String = ""
    required init() {}
}

