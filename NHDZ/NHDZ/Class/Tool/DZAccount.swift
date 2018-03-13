//
//  DZAccount.swift
//  NHDZ
//
//  Created by xiudou on 2018/3/13.
//  Copyright © 2018年 CoderST. All rights reserved.
//

import UIKit
let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
let DZAccountPath = path.appendingPathComponent("account.archive")
class DZAccount: NSObject {
    /**
     *  存储账号信息
     */
    class func saveAccount(_ account : DZAccountModel){
        // 自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
     NSKeyedArchiver.archiveRootObject(account, toFile: DZAccountPath)
    }
    
    /**
     *  返回账号信息
     */
    class func account()->DZAccountModel?{
        guard let account = NSKeyedUnarchiver.unarchiveObject(withFile: DZAccountPath) as? DZAccountModel else { return nil }
        return account
    }
}
