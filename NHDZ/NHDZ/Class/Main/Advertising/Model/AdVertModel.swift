//
//  AdVertModel.swift
//  DYZB
//
//  Created by xiudou on 2017/6/19.
//  Copyright © 2017年 xiudo. All rights reserved.
//

import UIKit

class AdVertModel: NSObject {
    var open_url : String = ""
    var track_url : String = ""
    var web_url : String = ""
    var splash_id : Int = 0
    var skip_btn : Int = 0
    var id : Int = 0
    var display_density : String = ""
    var title : String = ""
    var url : String = ""
    var display_time_ms : Int = 0
    var showTime : Int{
        get{
            return display_time_ms / 1000
        }
    }
    
//    var open_url : String = ""
//    var open_url : String = ""
    
    
/*
     "open_url":"",
     "track_url":"",
     "web_url":"http://rh.code.jjyx.com/sycode/113801.html",
     "splash_id":62437471520,
     "skip_btn":1,
     "id":62437471520,
     "display_density":"640x920",
     "expire_seconds":35181,
     "display_after":0,
     "title":"",
     "click_track_url_list":[
     
     ],
     "leave_interval":600,
     "expire_timestamp":1498492800,
     "track_url_list":[
     
     ],
     "image_info":{
     "width":640,
     "url_list":[
     {
     "url":"http://p3.pstatp.com/origin/287f00117f553c080677"
     },
     {
     "url":"http://pb9.pstatp.com/origin/287f00117f553c080677"
     },
     {
     "url":"http://pb1.pstatp.com/origin/287f00117f553c080677"
     }
     ],
     "uri":"287f00117f553c080677",
     "height":920
     },
     "type":"web",
     "display_time":3,
     "repeat":0,
     "splash_load_type":2,
     "predownload":31,
     "click_btn":0,
     "max_display_time_ms":4000,
     "banner_mode":1,
     "url":"http://p3.pstatp.com/origin/287f00117f553c080677",
     "display_time_ms":3000,
     "splash_interval":7200,
     "action":""
     }
     */
    
    // 自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
