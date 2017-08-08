//
//  STHomeViewController.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/7/31.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit

class STHomeViewController: UIViewController {

    fileprivate lazy var titlesVM : STTitlesViewModel = STTitlesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        automaticallyAdjustsScrollViewInsets = false
        
        setupData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        removeOrAddTitleView(isHidden: false, navigationBar: navigationController!.navigationBar)
        setStatusBarBackgroundColor(UIColor.orange)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
        removeOrAddTitleView(isHidden: true, navigationBar: navigationController!.navigationBar)
        setStatusBarBackgroundColor(UIColor.clear)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = UIColor.green
//        print("mmmmmm/mmmm",view.frame)

    }
    
    // 移除和添加titleView
    fileprivate func removeOrAddTitleView(isHidden : Bool, navigationBar : UINavigationBar) {
        
        for subView in navigationBar.subviews{
            
            if subView is STTitlesView{
                subView.isHidden = isHidden
            }
        }
        
    }
    
    ///设置状态栏背景颜色
    func setStatusBarBackgroundColor(_ color : UIColor) {
        let statusBarWindow : UIView = UIApplication.shared.value(forKey: "statusBarWindow") as! UIView
        let statusBar : UIView = statusBarWindow.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = color
        }
    }

    deinit {
        STPlayerManageAPI.removeAll()
        print("STHomeViewController - 销毁")
    }
}


extension STHomeViewController {
    
    fileprivate func setupData() {
        titlesVM.loadTitlesDatas(finishCallBack: {
            // 获得titles数据
            let titleModelArray = self.titlesVM.titleModelArray
            // 去除titles
            var titles : [String] = [String]()
            // 创建零时数组
            var childsVC = [UIViewController]()
            for titleModel in titleModelArray{
                let title = titleModel.name
                titles.append(title)
                let subVC = STHomeSubViewController()
                subVC.titleModel = titleModel
                childsVC.append(subVC)
            }
            let rect = CGRect(x: 0, y: NavAndStatusTotalHei, width: sScreenW, height: sScreenH - NavAndStatusTotalHei - TabbarHei)
            // 样式
            let style = STPageViewStyle()
            style.titleMargin = 20
            style.isShowScrollLine = true
            style.isScrollEnable = true
            style.normalColor = UIColor(r: 250, g: 250, b: 250, alpha: 0.8)
            style.selectColor = UIColor(r: 255.0, g: 255.0, b: 255.0)
            style.bottomLineColor = UIColor.white
            style.titleViewBackgroundColor = UIColor.orange
            // titleView
            let titleView = self.navigationController?.navigationBar
            let pageView = STPageView(frame: rect, titles: titles, childsVC: childsVC, parentVC: self, style: style, titleViewParentView: titleView)
            self.view.addSubview(pageView)
        }) { (message) in
            
        }
    }
}
