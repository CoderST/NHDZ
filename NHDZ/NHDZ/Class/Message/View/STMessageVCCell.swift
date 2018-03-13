//
//  STMessageVCCell.swift
//  NHDZ
//
//  Created by xiudou on 2018/3/13.
//  Copyright © 2018年 CoderST. All rights reserved.
//

import UIKit
class STMessageVCCell: UICollectionViewCell {
    
    fileprivate lazy var iconImageView : UIImageView = {
        let iconImageView = UIImageView()
        
        return iconImageView
    }()
    
    fileprivate lazy var nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = userNameFont
        return nameLabel
    }()
    
    fileprivate lazy var lineView : UIView = {
       
        let lineView = UIView()
        lineView.backgroundColor = lineViewColor
        return lineView
    }()
    
    var messageModel : STMessageModel?{
        
        didSet{
            guard let messageModel = messageModel else { return }
            iconImageView.image = UIImage(named: messageModel.icon)
            nameLabel.text = messageModel.name
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(lineView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.frame = CGRect(x: margin, y: (frame.height - userIconHW) * 0.5, width: userIconHW, height: userIconHW)
        let x = iconImageView.frame.maxX + margin
        let maxWidth = frame.width - x
        nameLabel.frame = CGRect(x: x, y: 0, width: maxWidth, height: frame.height)
        lineView.frame = CGRect(x: 0, y: frame.height - lineViewHeight, width: sScreenW, height: lineViewHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
