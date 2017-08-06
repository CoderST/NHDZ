//
//  STCommentADView.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/5.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit

class STCommentADView: UIView {
    
    fileprivate lazy var adImageView : UIImageView = {
       
        let adImageView = UIImageView()
        adImageView.contentMode = .scaleAspectFit
        return adImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(adImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
