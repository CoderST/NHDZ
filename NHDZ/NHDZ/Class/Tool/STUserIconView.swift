//
//  STUserIconView.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/5.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
import Kingfisher
class STUserIconView: UIView {
    
    fileprivate lazy var iconImageView : UIImageView = {
       
        let iconImageView = UIImageView()
        
        return iconImageView
    }()

    var iconImageURLString : String?{
        
        didSet{
            guard let iconImageURLString = iconImageURLString else { return }
            guard let url = URL(string: iconImageURLString) else { return }
            iconImageView.kf.setImage(with: url, placeholder: UIImage(named: "big_defaulthead_head"))
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconImageView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        layer.cornerRadius = frame.width * 0.5
//        clipsToBounds = true
        iconImageView.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
