//
//  STCommentUserInforModel.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/4.
//  Copyright © 2017年 CoderST. All rights reserved.
//  用户

import UIKit
import HandyJSON
class STCommentUserInforModel: HandyJSON {

    var message: String = ""
    
    var data: UserData?
    required init() {}
}

class UserData: HandyJSON {
    
    var has_new_message: Bool = false
    
    var is_anchor: Bool = false
    
    var ID: Int = 0
    
    var hotsoon_id: Int = 0
    
    var description: String = ""
    
    var hotsoon_id_mark: String = ""
    
    var user_verified: Bool = false
    
    var followings: Int = 0
    
    var avatar_url: String = ""
    
    var pro_user_desc: String = ""
    
    var create_time: Int = 0
    
    var can_send_message: Bool = false
    
    var diamond_count: Int = 0
    
    var is_living: Bool = false
    
    var subscribe_count: Int = 0
    
    var name: String = ""
    
    var comment_count: Int = 0
    
    var city: String = ""
    
    var hotsoon_name: String?
    
    var followers: Int = 0
    
    var enable_live: Bool = false
    
    var new_followers: Int = 0
    
    var notification_count: Int = 0
    
    var screen_name: String = ""
    
    var is_following: Bool = false
    
    var user_id: Int = 0
    
    var gender: Int = 0
    
    var is_pro_user: Bool = false
    
    var fan_ticket_count: Int = 0
    
    var hotsoon_name_mark: String = ""
    
    var point: Int = 0
    
    var large_avatar_url: String = ""
    
    var repin_count: Int = 0
    
    var ugc_count: Int = 0
    required init() {}
}

