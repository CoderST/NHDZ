//
//  STDiscoverCell.swift
//  NHDZ
//
//  Created by xiudou on 2017/8/8.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
import Kingfisher
class STDiscoverCell: UICollectionViewCell {
    /// 分类头像
    fileprivate lazy var iconImageView : UIImageView = {
       
        let iconImageView = UIImageView()
        
        return iconImageView
    }()
    /// 标题
    fileprivate lazy var titleLabel : UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.font = userNameFont
        return titleLabel
    }()
    /// 子标题
    fileprivate lazy var subTitleLabel : UILabel = {
        
        let subTitleLabel = UILabel()
        subTitleLabel.font = userSubTitleFont
        return subTitleLabel
    }()
    /// 订阅 - 总帖数
    fileprivate lazy var sonTitleLabel : UILabel = {
        
        let sonTitleLabel = UILabel()
        sonTitleLabel.font = userSubTitleFont
        return sonTitleLabel
    }()
    /// 订阅按钮
    fileprivate lazy var subscriptionButton : UIButton = {
        
        let subscriptionButton = UIButton()
        subscriptionButton.setTitle("订阅", for: .normal)
        subscriptionButton.setTitleColor(.gray, for: .normal)
        subscriptionButton.layer.borderWidth = 0.5
        subscriptionButton.layer.borderColor = UIColor.gray.cgColor
        subscriptionButton.titleLabel?.font = userNameFont
        return subscriptionButton
    }()

    fileprivate lazy var bottomLineView : STBottomLineView = STBottomLineView()

    var discoverFrame : STDiscoverFrame?{
        
        didSet{
            guard let discoverFrame = discoverFrame else { return }
            setupFrame(discoverFrame)
            
            setupData(discoverFrame)
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(sonTitleLabel)
        contentView.addSubview(subscriptionButton)
        contentView.addSubview(subscriptionButton)
        contentView.addSubview(bottomLineView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension STDiscoverCell{
    
    fileprivate func setupFrame(_ discoverFrame : STDiscoverFrame){
        iconImageView.frame = discoverFrame.iconFrame
        titleLabel.frame = discoverFrame.titleLabelFrame
        let width = discoverFrame.subscriptionButtonFrame.origin.x - discoverFrame.iconFrame.maxX - 4 * margin
        subTitleLabel.frame = CGRect(x: discoverFrame.subTitleLabelFrame.origin.x, y: discoverFrame.subTitleLabelFrame.origin.y, width: width, height: discoverFrame.subTitleLabelFrame.height)
        sonTitleLabel.frame = discoverFrame.sonTitleLabelFrame
        subscriptionButton.frame = discoverFrame.subscriptionButtonFrame
        bottomLineView.frame = discoverFrame.bottomLineFrame
    }
    
    fileprivate func setupData(_ discoverFrame : STDiscoverFrame){
        let urlString = discoverFrame.iconUrlString
        if let url = URL(string: urlString){
            iconImageView.kf.setImage(with: url)
        }
        
        titleLabel.text = discoverFrame.title
        subTitleLabel.text = discoverFrame.subTitle
        sonTitleLabel.text = discoverFrame.sonTitle
    }
}
