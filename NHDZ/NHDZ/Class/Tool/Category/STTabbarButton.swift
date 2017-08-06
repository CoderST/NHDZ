//
//  STTabbarButton.swift
//  STPageView
//
//  Created by xiudou on 2016/12/8.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit
private let buttonScale : CGFloat = 0.65
class STTabbarButton: UIButton {


    /// 重写父类方法,禁止按钮选中高亮状态
    override var isHighlighted: Bool {
        
        get{ return false }
        
        set {
            
        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView?.contentMode = .center
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
        setTitleColor(iOS7 ? .gray : .orange, for: .normal)
        setTitleColor(iOS7 ? .black : .purple, for: .selected)
        
    }

    
    
    class func creatButton(_ item : UITabBarItem)->STTabbarButton?{
        let button = STTabbarButton(type: .custom)
        guard let normalImage = item.image else { return nil }
        guard let selectedImage = item.selectedImage else { return nil }
        button.setImage(normalImage, for: UIControlState())
        button.setImage(selectedImage, for: .selected)
        button.setTitle(item.title, for: UIControlState())
        return button
    }
    
    
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let  imageW = contentRect.size.width;
        let imageH = contentRect.size.height * buttonScale;
        return CGRect(x: 0, y: 0, width: imageW, height: imageH);
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleY = contentRect.size.height * buttonScale;
        let titleW = contentRect.size.width;
        let titleH = contentRect.size.height - titleY;
        return CGRect(x: 0, y: titleY, width: titleW, height: titleH);
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
