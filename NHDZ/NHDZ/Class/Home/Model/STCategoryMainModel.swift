//
//  STCategoryMainModel.swift
//  NHDZ
//
//  Created by xiudou on 2017/8/7.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
import HandyJSON
class STCategoryMainModel: HandyJSON {

    var message: String = ""
    
    var data: BigData?
    
    required init() {}
}

class BigData: HandyJSON {
    
    var has_more: Bool = false
    
    var min_time: Int = 0
    
    var tip: String?
    
    var data: [ContentAndComment] = [ContentAndComment]()
    
    var category_info: Category_Info?
    
    var max_time: Int = 0
    
    var has_new_message: Bool = false
    
    required init() {}
}

class Category_Info: HandyJSON {
    
    var is_recommend: Bool = false
    
    var icon: String = ""
    
    var share_type: Int = 0
    
    var mix_weight: String = ""
    
    var ID: Int = 0
    
    var background_image: String = ""
    
    var is_top: Bool = false
    
    var icon_url: String = ""
    
    var total_updates: Int = 0
    
    var small_icon_url: String = ""
    
    var is_risk: Bool = false
    
    var is_my_subscription: Bool = false
    
    var big_category_id: Int = 0
    
    var top_start_time: String = ""
    
    var is_my_top: Bool = false
    
    var buttons: String = ""
    
    var type: Int = 0
    
    var extra: String = ""
    
    var allow_text: Int = 0
    
    var intro: String = ""
    
    var post_rule_id: Int = 0
    
    var tag: String = ""
    
    var priority: Int = 0
    
    var subscribe_count: Int = 0
    
    var allow_multi_image: Int = 0
    
    var name: String = ""
    
    var today_updates: Int = 0
    
    var status: Int = 0
    
    var small_icon: String = ""
    
    var top_end_time: String = ""
    
    var visible: Bool = false
    
    var material_bar: [String] = [String]()
    
    var allow_gif: Int = 0
    
    var allow_text_and_pic: Int = 0
    
    var allow_video: Int = 0
    
    var channels: String = ""
    
    var dedup: Int = 0
    
    var placeholder: String = ""
    
    var has_timeliness: Bool = false
    
    required init() {}
}

