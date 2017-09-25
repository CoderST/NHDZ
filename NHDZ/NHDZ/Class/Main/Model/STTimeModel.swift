//
//  STTimeModel.swift
//  NHDZ
//
//  Created by xiudou on 2017/9/25.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
import HandyJSON
class STTimeModel: HandyJSON {
    var magic_tag: String = ""
    var message: String = ""
    var server_time: Int = 0
    
    required init() {}
}
