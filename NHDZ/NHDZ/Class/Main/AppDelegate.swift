//
//  AppDelegate.swift
//  NHDZ
//
//  Created by xiudou on 2017/6/26.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
import XHLaunchAd
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // 设置住窗口
        setupMainWindow()
        // 添加广告
        addAd()

        // 获取时间
        STBaseVM.requestNewestTime()
        // 开始本地计时
        STTimeManage.shareInstance.start()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    
    func setupMainWindow() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = MainTabBarController()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

// MARK:- 广告
extension AppDelegate {
    
    func addAd(){
        //设置数据等待时间 请求广告URL前,必须设置,否则会先进入window的RootVC
        XHLaunchAd.setWaitDataDuration(3)
        let URLString = "http://lf.snssdk.com/service/12/app_ad/?iid=11612214903&idfa=99F096BA-477A-4D0A-AB26-69B76DDB85C6&version_code=5.8.0&device_type=iPhone%205%20(Global)&live_sdk_version=130&os_version=8.4&screen_width=640&aid=7&vid=D5CDF3B6-1637-454E-B4BD-5CA1DF31E543&device_id=4598024398&os_api=18&app_name=joke_essay&device_platform=iphone&ac=WIFI&openudid=7881ad6e7d291af91681a760a49f1202e5954292&channel=App%20Store&access=WIFI&app_name=joke_essay&carrier=%E4%B8%AD%E5%9B%BD%E7%A7%BB%E5%8A%A8&channel=App%20Store&device_id=4598024398&device_platform=iphone&device_type=iPhone%205%20%28Global%29&display_density=640x1136&mcc_mnc=&openudid=7881ad6e7d291af91681a760a49f1202e5954292&os_version=8.4&version_code=5.8.0"
        
        NetworkTools.requestData(.get, URLString: URLString) { (result) in
            
            guard let result = result as? [String : Any] else { return }
            
            debugLog(result)
            guard let message = result["message"] as? String else { return }
            
            if message != "success" {
                debugLog(result)
                return
            }
            
            guard let resultDataDict = result["data"] as? [String : Any] else {return}  //
             guard let resultDictArray = resultDataDict["splash"] as? [[String : Any]] else {return}
            var adModels : [AdVertModel] = [AdVertModel]()
            for dict in resultDictArray{
                let adModel = AdVertModel(dict: dict)
                adModels.append(adModel)
            }
            
            guard let adModel = adModels.last else { return }
            //2.自定义配置
            let imageAdconfiguration = XHLaunchImageAdConfiguration()
            //广告停留时间
            imageAdconfiguration.duration = adModel.showTime
            //广告frame
            imageAdconfiguration.frame = CGRect(x: 0, y: 0, width: sScreenW, height: sScreenH)
            //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
            imageAdconfiguration.imageNameOrURLString = adModel.url
            //网络图片缓存机制(只对网络图片有效)
            imageAdconfiguration.imageOption = .refreshCached
            //图片填充模式
            imageAdconfiguration.contentMode = .scaleToFill
            //广告点击打开链接
            imageAdconfiguration.openURLString = adModel.web_url
            //广告显示完成动画
            imageAdconfiguration.showFinishAnimate = .fadein
            //广告显示完成动画时间
            //            imageAdconfiguration.showFinishAnimateTime = 0.8
            //跳过按钮类型
            imageAdconfiguration.skipButtonType = .timeText
            //后台返回时,是否显示广告
            imageAdconfiguration.showEnterForeground = false
            //            let view = UIView()
            //            view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            //            view.backgroundColor = UIColor.red
            //            imageAdconfiguration.subViews = [view]
            //显示图片开屏广告
            XHLaunchAd.imageAd(with: imageAdconfiguration, delegate: self)
        }
    }
    
}

// MARK:- 点击广告跳转
extension AppDelegate : XHLaunchAdDelegate{
    func xhLaunchAd(_ launchAd: XHLaunchAd, clickAndOpenURLString openURLString: String) {
        let adVC = ADLinkViewController()
        adVC.openURLString = openURLString
        let tabVC = window?.rootViewController as!UITabBarController
        let nav = tabVC.selectedViewController as!UINavigationController
        nav.pushViewController(adVC, animated: true)
    }
}


