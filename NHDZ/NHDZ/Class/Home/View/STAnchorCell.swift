//
//  STAnchorCell.swift
//  NHDZ
//
//  Created by xiudou on 2017/8/16.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit

class STAnchorCell: UICollectionViewCell {
    
    /// 用户头像
    fileprivate lazy var userIconImageView : STUserIconView = {
        
        let userIconImageView = STUserIconView()
        
        return userIconImageView
        
    }()
    /// 用户名称
    fileprivate lazy var userNameLabel : UILabel = {
        
        let userNameLabel = UILabel()
        userNameLabel.font = userNameFont
        return userNameLabel
        
    }()
    
    /// 用户子标题
    fileprivate lazy var userSubTitleLabel : UILabel = {
        
        let userSubTitleLabel = UILabel()
        userSubTitleLabel.font = userSubTitleFont
        return userSubTitleLabel
        
    }()
    
    /// 图像
    fileprivate lazy var userImageView : UIImageView = {
        
        let userImageView = UIImageView()
        
        return userImageView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(userIconImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(userSubTitleLabel)
        contentView.addSubview(userImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var anchorFrame : STAnchorModelFrame?{
        
        didSet{
            guard let anchorFrame = anchorFrame else { return }
            setupUI(anchorFrame)
            setupData(anchorFrame)
        }
    }
}

extension STAnchorCell {
    
    fileprivate func setupData(_ anchorFrame : STAnchorModelFrame){
        userIconImageView.iconImageURLString = anchorFrame.userIconString
        userNameLabel.text = anchorFrame.userNameLabelString
        userSubTitleLabel.text = anchorFrame.localLabelString
        guard let url = URL(string: anchorFrame.userImageViewString) else { return }
        userImageView.kf.setImage(with: url, placeholder: UIImage(named: "big_defaulthead_head"))
    }
    
    fileprivate func setupUI(_ anchorFrame : STAnchorModelFrame){
        userIconImageView.frame = anchorFrame.userIconFrame
        userNameLabel.frame = anchorFrame.userNameLabelFrame
        userSubTitleLabel.frame = anchorFrame.localLabelFrame
        userImageView.frame = anchorFrame.userImageViewFrame
    }
}
