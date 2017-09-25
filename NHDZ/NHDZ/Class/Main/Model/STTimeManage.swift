//
//  STTimeManage.swift
//  NHDZ
//
//  Created by xiudou on 2017/9/25.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit

class STTimeManage: NSObject {

    var timeInterval : TimeInterval = 0
    var time : Timer?
    
    static let shareInstance : STTimeManage = STTimeManage()
    
    func start() {
        time = Timer(timeInterval: 1, target: self, selector: #selector(timeAction), userInfo: nil, repeats: true)
        RunLoop.main.add(time!, forMode: .commonModes)
    }
    
    func reload() {
        timeInterval = 0
        
    }
    
    func timeAction() {
        timeInterval = timeInterval + 1
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: TimeActionNotification), object: nil, userInfo: ["timeInterval" : timeInterval])
    }
    
    func timeInvalidate() {
        timeInterval = 0
        time?.invalidate()
        time = nil
    }

}
