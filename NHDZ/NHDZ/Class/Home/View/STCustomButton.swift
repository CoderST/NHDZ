//
//  STCustomButton.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/2.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
enum CustomButtonType {
    case zanButton
    case caiButton
    case commentButton
    case shareButton
}
class STCustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView?.contentMode = .center
        titleLabel?.textAlignment = .left
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = CGRect(x: 0, y: 0, width: frame.width * 0.4, height: frame.height)
        
        titleLabel?.frame = CGRect(x: frame.width * 0.4, y: 0, width: frame.width * 0.6, height: frame.height)
    }
}
