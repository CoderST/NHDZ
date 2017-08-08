//
//  STDiscoverMainModel.swift
//  NHDZ
//
//  Created by xiudou on 2017/8/7.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
import HandyJSON
class STDiscoverMainModel: HandyJSON {
    var message: String = ""
    
    var data: DiscoverData?
    required init() {}
}

class DiscoverData: HandyJSON {
    
    var my_top_category_list: [String] = [String]()
    
    var rotate_banner: Rotate_Banner?
    
    var categories: Categories?
    
    var god_comment: God_Comment?
    
    var my_category_list: [String] = [String]()
    required init() {}
}

class God_Comment: HandyJSON {
    
    var icon: String = ""
    
    var count: Int = 0
    
    var intro: String = ""
    
    var name: String = ""
    required init() {}
}

class Rotate_Banner: HandyJSON {
    
    var count: Int = 0
    
    var banners: [Banners] = [Banners]()
    required init() {}
}

class Banners: HandyJSON {
    
    var schema_url: String = ""
    
    var target_users: [String] = [String]()
    
    var banner_url: Banner_Url?
    required init() {}
}

class Banner_Url: HandyJSON {
    
    var ID: Int = 0
    
    var title: String = ""
    
    var url_list: [Url_List] = [Url_List]()
    
    var height: Int = 0
    
    var uri: String = ""
    
    var width: Int = 0
    required init() {}
}

class Url_List: HandyJSON {
    
    var url: String = ""
    required init() {}
}

class Categories: HandyJSON {
    
    var priority: Int = 0
    
    var category_count: Int = 0
    
    var ID: Int = 0
    
    var intro: String = ""
    
    var category_list: [DiscoverModel] = [DiscoverModel]()
    
    var icon: String = ""
    
    var name: String = ""
    required init() {}
}

class DiscoverModel: HandyJSON {
    
    var is_recommend: Bool = false
    
    var icon: String = ""
    
    var share_type: Int = 0
    
    var mix_weight: String = ""
    
    var ID: Int = 0
    
    var is_top: Bool = false
    
    var icon_url: String = ""
    
    var total_updates: Int = 0
    
    var small_icon_url: String = ""
    
    var is_risk: Bool = false
    
    var big_category_id: Int = 0
    
    var top_start_time: String = ""
    
    var type: Int = 0
    
    var buttons: String = ""
    
    var allow_text: Int = 0
    
    var extra: String = ""
    
    var tag: String = ""
    
    var intro: String = ""
    
    var post_rule_id: Int = 0
    
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
    
    var share_url: String = ""
    
    var placeholder: String = ""
    
    var has_timeliness: Bool = false
    required init() {}
}
