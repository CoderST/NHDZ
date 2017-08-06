//
//  MainTabBarController.swift
//  NHDZ
//
//  Created by xiudou on 2017/6/26.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit

let iOS7 = Double(UIDevice.current.systemVersion)! >= 7.0
class MainTabBarController: UITabBarController {

    // MARK:- 懒加载
    fileprivate lazy var customTabBar : STTabbar = {[weak self] in
        let customTabBar = STTabbar()
        customTabBar.delegate = self
        customTabBar.frame = self!.tabBar.bounds
        return customTabBar
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置tabBar
        setUpTabBarView()
        // 设置子控制器
        setupChildsVC()
        
        
        let rect = CGRect(x: 0, y: 0, width: sScreenW, height: sScreenH);
        
        UIGraphicsBeginImageContext(rect.size);
        
        let context = UIGraphicsGetCurrentContext();
        
        context?.setFillColor(UIColor.clear.cgColor);
        
        context?.fill(rect);
        
        let img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        tabBar.backgroundImage = img
        tabBar.shadowImage = img
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 去除系统的item
        for subView in tabBar.subviews{
            guard subView is UIControl else { continue }
            subView.removeFromSuperview()
        }
    }

}

extension MainTabBarController {
    
    // 添加自定义tabBar
    fileprivate func setUpTabBarView() {
        tabBar.addSubview(customTabBar)
    }
    
    // 创建子控制器
    fileprivate func setupChildsVC() {
        
        addChildVc(STHomeViewController(), title: "首页", normalImageName: "home_normal", selectedImageName: "home_door_press")
        addChildVc(DiscoverViewController(), title: "发现", normalImageName: "Found_night", selectedImageName: "Found_press")
        addChildVc(FreshViewController(), title: "新鲜", normalImageName: "freshnew_night", selectedImageName: "freshnew_press")
        addChildVc(MessageViewController(), title: "消息", normalImageName: "newstab_night", selectedImageName: "newstab_press")
    }
    
    // 子控制器实现
    fileprivate func addChildVc(_ childVc : UIViewController, title : String, normalImageName : String, selectedImageName : String){
        // 标题
//        childVc.title = title
        childVc.tabBarItem.title = title
        // 图片
        childVc.tabBarItem.image = UIImage(named: normalImageName)
        guard let selectedImage = UIImage(named: selectedImageName) else {
            
            debugLog("没有选中的图片")
            return }
        if iOS7{
            childVc.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        }else{
            childVc.tabBarItem.selectedImage = selectedImage
        }
        
        let mainNav = MainNavigationController(rootViewController: childVc)
        
        addChildViewController(mainNav)
        
        customTabBar.creatTabbarItem(childVc.tabBarItem)
    }
}

extension MainTabBarController : STTabbarDelegate{
    func didSelectButtonAtIndex(_ stTabbar: STTabbar, index: Int) {
        selectedIndex = index
    }
}
