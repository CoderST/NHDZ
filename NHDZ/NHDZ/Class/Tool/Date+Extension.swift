//
//  STProgressView.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/7/30.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
// MARK:- string -> date
extension Date {
    static func dateFromString(_ dateFormat : String, _ dateString : String)->Date?{
        // 2.初始化DateFormatter类
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        
        dateFormatter.dateFormat = dateFormat
        guard let date = dateFormatter.date(from: dateString) else { return nil}
        return date
    }
}
extension Date{
    /// 获取当前时间 -> String
    static func getNowDate() ->String{
        let date = Date()
        
        let time = Int(date.timeIntervalSince1970)
        
        return "\(time)"
    }
    
    /// 获取当前时间 -> Int
    static func getNowDateInt()->Int{
        let date = Date()
        
        let time = Int(date.timeIntervalSince1970)
        
        return time
    }
}

// MARK:- 多少分钟前
extension Date{
    public static func createDateString(_ createAtStr : String) -> String {
        
        let string = NSString(string: createAtStr)
        
        let timeSta : TimeInterval = string.doubleValue
        let fmt = DateFormatter()
        //        dfmatter.dateFormat="yyyy年MM月dd日"
        
        let createDate = Date(timeIntervalSince1970: timeSta)
        
        
        // 3.创建当前时间
        let nowDate = NSDate()
        
        // 4.计算创建时间和当前时间的时间差
        let interval = Int(nowDate.timeIntervalSince(createDate))
        
        // 5.对时间间隔处理
        // 5.1.显示刚刚
        if interval < 60 {
            return "刚刚"
        }
        
        // 5.2.59分钟前
        if interval < 60 * 60 {
            return "\(interval / 60)分钟前"
        }
        
        // 5.3.11小时前
        if interval < 60 * 60 * 24 {
            return "\(interval / (60 * 60))小时前"
        }
        
        // 5.4.创建日历对象
        let calendar = NSCalendar.current
        
        // 5.5.处理昨天数据: 昨天 12:23
        if calendar.isDateInYesterday(createDate) {
            fmt.dateFormat = "昨天 HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
        
        // 5.6.处理一年之内: 02-22 12:22
        let cmps = (calendar as NSCalendar).components(.year, from: createDate, to: nowDate as Date, options: [])
        if cmps.year! < 1 {
            fmt.dateFormat = "MM-dd HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
        
        // 5.7.超过一年: 2014-02-12 13:22
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        let timeStr = fmt.string(from: createDate)
        return timeStr
    }
}

extension Date{
    func getShowFormat(requestDate:Date) -> String {
        
        //获取当前时间
        let calendar = Calendar.current
        //判断是否是今天
        if calendar.isDateInToday(requestDate as Date) {
            //获取当前时间和系统时间的差距(单位是秒)
            //强制转换为Int
            let since = Int(Date().timeIntervalSince(requestDate as Date))
            //  是否是刚刚
            if since < 60 {
                return "刚刚"
            }
            //  是否是多少分钟内
            if since < 60 * 60 {
                return "\(since/60)分钟前"
            }
            //  是否是多少小时内
            return "\(since / (60 * 60))小时前"
        }
        
        //判断是否是昨天
        var formatterString = " HH:mm"
        if calendar.isDateInYesterday(requestDate as Date) {
            formatterString = "昨天" + formatterString
        } else {
            //判断是否是一年内
            formatterString = "MM-dd" + formatterString
            //判断是否是更早期
            
            let comps = calendar.dateComponents([Calendar.Component.year], from: requestDate, to: Date())
            
            if comps.year! >= 1 {
                formatterString = "yyyy-" + formatterString
            }
        }
        
        //按照指定的格式将日期转换为字符串
        //创建formatter
        let formatter = DateFormatter()
        //设置时间格式
        formatter.dateFormat = formatterString
        //设置时间区域
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale!
        
        //格式化
        return formatter.string(from: requestDate as Date)
    }
}

// MARK:- 指定formal 返回对应的时间
/*
 timeDateFormat : 日期样式 必须要和time格式一致
 time       : 时间
 toDateFormat : 最终需要的格式
 */
extension Date {
    
    static func getTimeFromeFormat(timeDateFormat : String, toDateFormat : String, time : String)->String?{
        let formatter = DateFormatter()
        formatter.dateFormat = timeDateFormat
        guard let date =  formatter.date(from: time) else {return nil}
        formatter.dateFormat = toDateFormat
        let string =  formatter.string(from: date)
        return string
    }
}

// MARK:- date -> string
extension Date {
    func stringFromDate(date : Date){
        
    }
}


