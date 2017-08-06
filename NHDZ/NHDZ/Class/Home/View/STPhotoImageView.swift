//
//  STPhotoView.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/7/29.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
//import SDWebImage
import Kingfisher
class STPhotoImageView: UIImageView {


    fileprivate lazy var gifImageView : UIImageView = {
       
        let image = UIImage(named: "timeline_image_gif")
        let gifImageView = UIImageView(image: image)
        return gifImageView
        
    }()
    
    var thumbImage : ThumbImage?{
        
        didSet{
            
            guard let thumbImage = thumbImage else { return }
            let url = URL(string: thumbImage.url)
            kf.setImage(with: url, placeholder: UIImage(named: "timeline_image_placeholder"))
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        contentMode = .scaleToFill
        clipsToBounds = true
        addSubview(gifImageView)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gifImageView.frame.origin.x = frame.width - gifImageView.frame.width
        gifImageView.frame.origin.y = frame.height - gifImageView.frame.height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

