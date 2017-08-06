//
//  STBottomToolBarView.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/2.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit

class STBottomToolBarView: UIView {

    fileprivate lazy var buttonArray : [STCustomButton] = [STCustomButton]()
    
    /// 赞
    fileprivate lazy var zanButton : STCustomButton = {
        let zanButton = STCustomButton()
        zanButton.setImage(UIImage(named: "digupicon_textpage"), for: .normal)
        zanButton.setImage(UIImage(named: "digupicon_textpage_night"), for: .highlighted)
        return zanButton
    }()
    /// 踩
    fileprivate lazy var caiButton : STCustomButton = {
        let caiButton = STCustomButton()
        caiButton.setImage(UIImage(named: "digdownicon_textpage"), for: .normal)
        caiButton.setImage(UIImage(named: "digdownicon_textpage_night"), for: .highlighted)
        return caiButton
    }()
    /// 评论
    fileprivate lazy var commentButton : STCustomButton = {
        let commentButton = STCustomButton()
        commentButton.setImage(UIImage(named: "commenticon_textpage"), for: .normal)
        commentButton.setImage(UIImage(named: "commenticon_textpage_night"), for: .highlighted)
        return commentButton
    }()
    /// 转发
    fileprivate lazy var shareButton : STCustomButton = {
        let shareButton = STCustomButton()
        shareButton.setImage(UIImage(named: "moreicon_textpage"), for: .normal)
        shareButton.setImage(UIImage(named: "moreicon_textpage_night"), for: .highlighted)
        return shareButton
    }()
    
    var content : Content?{
        
        didSet{
            
            guard let content = content else { return }
            let digg_countString = String.countStringFrome(content.digg_count)
            let bury_countString = String.countStringFrome(content.bury_count)
            let comment_countString = String.countStringFrome(content.comment_count)
            let share_countString = String.countStringFrome(content.share_count)
            
            zanButton.setTitle(digg_countString, for: .normal)
            caiButton.setTitle(bury_countString, for: .normal)
            commentButton.setTitle(comment_countString, for: .normal)
            shareButton.setTitle(share_countString, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(zanButton)
        addSubview(caiButton)
        addSubview(commentButton)
        addSubview(shareButton)
        
        buttonArray = [zanButton,caiButton,commentButton,shareButton]
        
        zanButton.tag = CustomButtonType.zanButton.hashValue
        caiButton.tag = CustomButtonType.caiButton.hashValue
        commentButton.tag = CustomButtonType.commentButton.hashValue
        shareButton.tag = CustomButtonType.shareButton.hashValue
        
        zanButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        caiButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = frame.width
        let height = frame.height
        let count = buttonArray.count
        let buttonWidth = width / CGFloat(count)
        let buttonHeihgt = height
        for (i,button) in buttonArray.enumerated(){
            let buttonX = CGFloat(i) * buttonWidth
            button.frame = CGRect(x: buttonX, y: 0, width: buttonWidth, height: buttonHeihgt)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension STBottomToolBarView {
    func buttonAction(_ sender: STCustomButton){
        let tag = sender.tag
        switch tag {
        case CustomButtonType.zanButton.hashValue:
            print("赞")
        case CustomButtonType.caiButton.hashValue:
            print("踩")
        case CustomButtonType.commentButton.hashValue:
            print("评论")
        case CustomButtonType.shareButton.hashValue:
            print("分享")
        default:
            print("")
        }
    }
}
