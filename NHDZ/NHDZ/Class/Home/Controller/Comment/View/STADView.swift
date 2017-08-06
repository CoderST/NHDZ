//
//  STADView.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/5.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
import Kingfisher
class STADView: UIView {

    fileprivate lazy var adImageView : UIImageView = {
       
        let adImageView = UIImageView()
        
        
        return adImageView
    }()
    
    fileprivate lazy var titleLabel : UILabel = {
       
        let titleLabel = UILabel()
        titleLabel.font = commentTitleFont
        
        return titleLabel
    }()
    
    var commentADModelFrame : STCommentADModelFrame?{
        
        didSet{
            
            guard let commentADModelFrame = commentADModelFrame else { return }
            
            adImageView.frame = commentADModelFrame.adImageViewFrame
            titleLabel.frame = commentADModelFrame.adContentLabelFrame
            
            let urlString = commentADModelFrame.adModel.ad?.image_infos?.first?.url ?? ""
            guard let url = URL(string: urlString) else { return }
            adImageView.kf.setImage(with: url)
            
            let title = commentADModelFrame.adModel.ad.debugDescription 
            titleLabel.text = title
            
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(adImageView)
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
