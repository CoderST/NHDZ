//
//  STDislikeResonCell.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/3.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
fileprivate let statusButtonWH : CGFloat = 20
class STDislikeResonCell: UICollectionViewCell {
    
    fileprivate lazy var dislikeLabel : UILabel = {
        
        let dislikeLabel = UILabel()
        dislikeLabel.backgroundColor = UIColor.green
        return dislikeLabel
    }()
    
     lazy var statusButton : UIButton = {
        
        let statusButton = UIButton()
        statusButton.imageView?.contentMode = .center
        let normalImage = UIImage(named: "choice_night")
        statusButton.setImage(normalImage, for: .normal)
        let selectedImage = UIImage(named: "choice_press")
        statusButton.setImage(selectedImage, for: .selected)
        return statusButton
    }()
    
    var dislikeReason : Dislike_Reason?{
        
        didSet{
            
            guard let dislikeReason = dislikeReason else { return }
            
            dislikeLabel.text = dislikeReason.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(dislikeLabel)
        contentView.addSubview(statusButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dislikeLabel.frame = CGRect(x: 40, y: 0, width: frame.width - 40 - statusButtonWH - 2 * 10, height: frame.height)
        statusButton.frame = CGRect(x: frame.width - statusButtonWH - 10, y: 0, width: statusButtonWH, height: frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
