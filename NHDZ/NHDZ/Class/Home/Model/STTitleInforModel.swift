//
//  STTitleInforModel.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/7/31.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
import HandyJSON
class STTitleInforModel: HandyJSON {
    var message: String = ""
    
    var data: [TitleModle]?
    required init() {}
}

class TitleModle: HandyJSON {
    
    var url: String = ""
    
    var double_col_mode: Bool = false
    
    var list_id: Int = 0
    
    var umeng_event: String = ""
    
    var type: Int = 0
    
    var is_default_tab: Bool = false
    
    var name: String = ""
    
    var refresh_interval: Int = 0
    
    required init() {}
    
}
