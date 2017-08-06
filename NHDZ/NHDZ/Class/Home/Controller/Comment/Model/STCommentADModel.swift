//
//  STCommentADModel.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/4.
//  Copyright © 2017年 CoderST. All rights reserved.
//  广告

import UIKit
import HandyJSON
class STCommentADModel: HandyJSON {
    var message: String?
    
    var ad: Ad?
    required init() {}
}
class Ad: HandyJSON {
    
    var web_url: String = ""
    
    var image_mode: Int = 0
    
    var webview_width: Int = 0
    
    var label: String = ""
    
    var phone_number: String = ""
    
    var track_url: String = ""
    
    var track_url_list: [String]?
    
    var ID: Int = 0
    
    var display_type: Int = 0
    
    var button_text: String = ""
    
    var source: String = ""
    
    var type: String = ""
    
    var log_extra: String = ""
    
    var is_preview: Bool = false
    
    var image_infos: [Image_Infos]?
    
    var js_render: String = ""
    
    var webview_height: Int = 0
    
    var web_title: String = ""
    required init() {}
}

class Image_Infos: HandyJSON {
    
    var url: String = ""
    
    var width: Int = 0
    
    var height: Int = 0
    required init() {}
}


