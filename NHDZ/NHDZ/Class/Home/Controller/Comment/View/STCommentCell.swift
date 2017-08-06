//
//  STCommentCell.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/5.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit

class STCommentCell: UICollectionViewCell {
    
    /// 用户头像
    fileprivate lazy var userIconView : STUserIconView = STUserIconView()
    /// 用户名称
    fileprivate lazy var userNameLabel : UILabel = {
       
        let userNameLabel = UILabel()
        userNameLabel.font = userNameFont
        return userNameLabel
    }()
    /// 评论时间
    fileprivate lazy var timeLabel : UILabel = {
        
        let timeLabel = UILabel()
        timeLabel.font = userSubTitleFont
        return timeLabel
    }()
    
    /// 评论内容
    fileprivate lazy var contentLabel : UILabel = {
        
        let contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        contentLabel.font = commentTitleFont
        return contentLabel
    }()
    /// 赞按钮
    /// 分享按钮
    /// 底部灰色线
    fileprivate lazy var bottomLineView : STBottomLineView = STBottomLineView()
    
    var commentFrame : STCommentModelFrame?{
        
        didSet{
            guard let commentFrame = commentFrame else { return }
            
            setupUIFrame(commentFrame)
            
            setupData(commentFrame)
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(userIconView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(bottomLineView)
        
        contentLabel.backgroundColor = .red
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension STCommentCell {
    
    fileprivate func setupUIFrame(_ commentFrame : STCommentModelFrame){
        userIconView.frame = commentFrame.userIconViewFrame
        userNameLabel.frame = commentFrame.userNameLabelFrame
        timeLabel.frame = commentFrame.timeLabelFrame

        contentLabel.frame = commentFrame.contentLabelFrame

        bottomLineView.frame = commentFrame.bottomLineViewFrame

    }
    
    fileprivate func setupData(_ commentFrame : STCommentModelFrame){
        userIconView.iconImageURLString = commentFrame.singleCommentModel.avatar_url
        userNameLabel.text = commentFrame.userName
        timeLabel.text = commentFrame.timeString
        contentLabel.text = commentFrame.content
    }
}
