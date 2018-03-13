//
//  STMessageModel.swift
//  NHDZ
//
//  Created by xiudou on 2018/3/13.
//  Copyright © 2018年 CoderST. All rights reserved.
//

import UIKit

class STMessageModel: NSObject {
    /// 图片
    var icon : String = ""
    /// 标题
    var name : String = ""
    /// 目的控制器
    var desclass : AnyObject?
    
    init(_ icon : String, _ name : String, _ desclass : AnyObject?) {
        self.icon = icon
        self.name = name
        self.desclass = desclass
    }
}
