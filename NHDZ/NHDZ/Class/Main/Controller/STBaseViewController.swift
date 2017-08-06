//
//  STBaseViewController.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/6.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit

class STBaseViewController: UIViewController {


        // MARK:- 变量
        var baseContentView : UIView?
        
        // MARK:- 生命周期
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setupUI()
            
        }
        
        // MARK:- 懒加载
        fileprivate lazy var animationImageView : UIImageView = { [weak self] in
            
            let animationImageView = UIImageView(image: UIImage(named: "refreshjoke_loading_1"))
            
            animationImageView.center = self!.view.center
            var animationImageArray : [UIImage] = [UIImage]()
            // 创建数组图片
            for i in 0..<16{
                let index = i + 1
                let imageName = String(format: "refreshjoke_loading_%d",index)
                guard let image = UIImage(named: imageName) else { continue }
                animationImageArray.append(image)
            }
            
            animationImageView.animationImages = animationImageArray
            animationImageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
            animationImageView.animationDuration = 1.0
            animationImageView.animationRepeatCount = LONG_MAX
            return animationImageView
            
            }()


}

extension STBaseViewController {
    
    func setupUI(){
        // 1 停止子类view的显示
        baseContentView?.isHidden = true
        // 2 添加加载动画控件
        view.addSubview(animationImageView)
        // 3 显示加载动画控件
        animationImageView.isHidden = false
        // 4 开始加载动画
        animationImageView.startAnimating()
        // 5 设置背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    /**
     结束,隐藏动画
     */
    func endAnimation(){
        
        animationImageView.stopAnimating()
        
        animationImageView.isHidden = true
        
        baseContentView?.isHidden = false
    }
}
