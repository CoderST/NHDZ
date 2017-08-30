//
//  STAnchorMainModel.swift
//  NHDZ
//
//  Created by xiudou on 2017/8/16.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
import HandyJSON
class STAnchorMainModel: HandyJSON {
    var msg: String = ""
    
    var data: ListData?
    
    var code: String = ""

    required init() {}
}

class ListData: HandyJSON {
    
    var counts: Int = 0
    
    var list: [Anchor] = [Anchor]()
    
    required init() {}
    
}

class Anchor: HandyJSON {
    /** 用户ID */
    var userId: String = ""
    
    var familyName: String = ""
    
    var nationFlag: String = ""
    
    var useridx: Int = 0
    
    var starlevel: Int = 0
    /** 直播图 */
    var bigpic: String = ""
    /** 主播头像 */
    var smallpic: String = ""
    
    var isSign: Int = 0
    /** 主播名 */
    var myname: String = ""
    /** 直播流地址 */
    var flv: String = ""
    
    var nation: String = ""
    /** 直播房间号码 */
    var roomid: Int = 0
    
    var gameid: Int = 0
    
    var gender: Int = 0
    /** 排名 */
    var pos: Int = 0
    
    var allnum: Int = 0
    
    var distance: Int = 0
    
    var anchorlevel: Int = 0
    
    var serverid: Int = 0
    /** 所在城市 */
    var gps: String = ""
    
    required init() {}
    
}
