//
//  STTabbar.swift
//  STPageView
//
//  Created by xiudou on 2016/12/8.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit
// didSelectButtonAtIndex
protocol STTabbarDelegate : class{
    /// 控制器
    func didSelectButtonAtIndex(_ stTabbar : STTabbar, index : Int)
    /// 加号
    func didSelectplusButton(_ stTabbar : STTabbar, plusButton : STTabbarButton)
}
class STTabbar: UIView {
    
    // MARK:- 变量
    weak var delegate : STTabbarDelegate?
    
    fileprivate var selectedButton : STTabbarButton?
    
    // MARK:- 懒加载
    fileprivate lazy var itemButtonArray : [STTabbarButton] = [STTabbarButton]()
    
    fileprivate lazy var plusButton : STTabbarButton = {
        let plusButton = STTabbarButton(type: .custom)
        plusButton.setBackgroundImage(UIImage(named: "homepage_btn_play_n"), for: UIControlState())
        plusButton.setBackgroundImage(UIImage(named: "homepage_btn_play_n"), for: .highlighted)
        
        if let currentBackgroundImage = plusButton.currentBackgroundImage {
            plusButton.bounds = CGRect(x: 0, y: 0, width: currentBackgroundImage.size.width, height: currentBackgroundImage.size.height);
            plusButton.bounds = CGRect(x: 0, y: 0, width: currentBackgroundImage.size.width, height: currentBackgroundImage.size.height)
        }
        
        plusButton.addTarget(self, action: #selector(STTabbar.plusButtonAction(_:)), for: .touchDown)
        
        return plusButton
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if (!iOS7) {
            if let backImage = UIImage(named: "tabbar_background"){
                
                backgroundColor = UIColor(patternImage: backImage)
            }
            
            
        }
        backgroundColor = UIColor.white
        addSubview(plusButton)

    }
    

    @objc fileprivate func plusButtonAction(_ button : STTabbarButton){
//        print(plusButtonAction)
        delegate?.didSelectplusButton(self, plusButton: button)
    }

    

    func creatTabbarItem(_ item : UITabBarItem) {
        
        setupUI(item)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = frame.size.width
        let height = frame.size.height
        
        plusButton.center = CGPoint(x: width * 0.5, y: height * 0.5)
        
        let buttonWidth = width / CGFloat(subviews.count)
        let buttonHeight = height
        let buttonY : CGFloat = 0
        for (index,button) in itemButtonArray.enumerated(){
            button.tag = index
            index == 0 ? (button.isSelected = true) : (button.isSelected = false)
            if index == 0{
                button.isSelected = true
                selectedButton = button;
            }else{
                button.isSelected = false
            }
//            button.isSelected = index == 0 ? true : false
            var buttonX = CGFloat(index) * buttonWidth
            if index > 1 {
                buttonX = buttonX + buttonWidth
            }
            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

extension STTabbar {
    
     fileprivate func setupUI(_ item : UITabBarItem) {
        
        setupButton(item)
    }
    
     fileprivate func setupButton(_ item : UITabBarItem) {
        guard let tabbarButton = STTabbarButton.creatButton(item) else { return }
        tabbarButton.addTarget(self, action: #selector(STTabbar.tabbarButtonAction(_:)), for: .touchDown)
        addSubview(tabbarButton)
        itemButtonArray.append(tabbarButton)
    }
    
    @objc fileprivate func tabbarButtonAction(_ button : STTabbarButton){
        if button.tag == selectedButton?.tag { return }
        delegate?.didSelectButtonAtIndex(self, index: button.tag)
        selectedButton?.isSelected = false
        button.isSelected = true;
        selectedButton = button;
    }
}
