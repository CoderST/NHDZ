//
//  STCommentModel.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/4.
//  Copyright © 2017年 CoderST. All rights reserved.
//  评论所有数据

import UIKit
import HandyJSON
class STCommentBigModel: HandyJSON {
    var has_more: Bool = false
    
    var message: String = ""
    
    var data: CommentData?
    
    var total_number: Int = 0
    
    var new_comment: Bool = false
    
    var group_id: Int = 0
    required init() {}
}
class CommentData: HandyJSON {
    
    var top_comments: [STSingleCommentModel]?
    
    var recent_comments: [STSingleCommentModel]?
    
    var stick_comments: [String]?
    required init() {}
}

class STSingleCommentModel: HandyJSON {  // 一条评论
    
    var user_name: String = ""
    
    var user_profile_url: String = ""
    
    var status: Int = 0
    
    var group_id: Int = 0
    
    var is_digg: Int = 0
    
    var user_bury: Int = 0
    
    var create_time: Int = 0
    
    var user_id: Int = 0
    
    var digg_count: Int = 0
    
    var share_type: Int = 0
    
    var bury_count: Int = 0
    
    var user_verified: Bool = false
    
    var share_url: String = ""
    
    var avatar_url: String = ""
    
    var platform_id: String = ""
    
    var ID: Int = 0
    
    var is_pro_user: Bool = false
    
    var platform: String = ""
    
    var comment_id: Int = 0
    
    var user_digg: Int = 0
    
    var user_profile_image_url: String = ""
    
    var text: String = ""
    
    var second_level_comments_count: Int = 0
    
    var description: String = ""
    required init() {}
}


