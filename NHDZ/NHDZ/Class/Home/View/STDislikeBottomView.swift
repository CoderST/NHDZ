//
//  STDislikeBottomView.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/3.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit

class STDislikeBottomView: UIView {

    fileprivate lazy var cancelButton : UIButton = {
        let  cancelButton = UIButton()
        cancelButton.setTitle("取消", for: .normal)
        return cancelButton
    }()

    
    fileprivate lazy var yesButton : UIButton = {
        let  yesButton = UIButton()
        yesButton.setTitle("确定", for: .normal)
        return yesButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cancelButton)
        addSubview(yesButton)
        yesButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cancelButton.frame = CGRect(x: 0, y: 0, width: frame.width * 0.5, height: frame.height)
        yesButton.frame = CGRect(x: frame.width * 0.5, y: 0, width: frame.width * 0.5, height: frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension STDislikeBottomView {
    
    @objc fileprivate func buttonClick(_ sender : UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: DislikeNSNotification), object: self, userInfo: ["button": sender])
    }
}
