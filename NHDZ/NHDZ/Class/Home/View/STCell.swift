//
//  STCell.swift
//  转换坐标系
//
//  Created by xiudou on 2017/7/21.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
import AVFoundation
import Kingfisher

protocol STCellDelegate : class {
    
    func deleGroup(_ stCell : STCell, _ connotationModelFrame : STConnotationModelFrame?, _ indexPath : IndexPath)
}

public enum kJPPlayUnreachCellStyle : Int {
    
    case none // normal 播放滑动可及cell.
    
    case up // top 顶部不可及.
    
    case down // bottom 底部不可及.
}
class STCell: UICollectionViewCell {
    
    
    public var cellStyle : kJPPlayUnreachCellStyle? // cell类型
    
    public var videoPath = String()
    
    var isScrollowOutWindow : Bool = false
    
    weak var delegate : STCellDelegate?
    
    fileprivate var time : Timer?
    
    // MARK:- 懒加载
    /// 需要移动的View
    lazy var needMoveView : UIView = {
        
        let needMoveView = UIView()
//        needMoveView.backgroundColor = .red
        return needMoveView
        
    }()
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
        userSubTitleLabel.isHidden = true
        return userSubTitleLabel
        
    }()
    
    /// 用户的所有内容view
    lazy var userInforView : UIView = {
        
        let userInforView = UIView()
//        userInforView.backgroundColor = .yellow
        return userInforView
        
    }()
    
    /// 内容
    fileprivate lazy var contentLabel : UILabel = {
        
        let contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        contentLabel.font = titleFont
        return contentLabel
        
    }()
    
    /// 分类名称
    fileprivate lazy var categoryNameLabel : UILabel = {
        let categoryNameLabel = UILabel()
        categoryNameLabel.isUserInteractionEnabled = true
        categoryNameLabel.textAlignment = .center
        categoryNameLabel.font = titleFont
        categoryNameLabel.backgroundColor = .white
        categoryNameLabel.clipsToBounds = true
        categoryNameLabel.layer.borderWidth = 0.5
        categoryNameLabel.layer.borderColor = UIColor.black.cgColor
        return categoryNameLabel
    }()
    
    /// 单个图片
    fileprivate lazy var pictureImageView : STCellPictureView = {
        
        let pictureImageView = STCellPictureView()
        return pictureImageView
        
    }()
    /// gif图片
    fileprivate lazy var gifImageView : STCellPictureView = {
        
        let gifImageView = STCellPictureView()
        return gifImageView
        
    }()
    /// 视频
    lazy var videlView : STVideoView = {
        
        let videlView = STVideoView()
        return videlView
        
    }()
    
    /// 多图View
    fileprivate lazy var photosView : STPhotosView = {
        
        let photosView = STPhotosView()
        return photosView
        
    }()
    
    /// 底部bottomTabbarView
    fileprivate lazy var bottomTabbarView : STBottomToolBarView = {
        
        let bottomTabbarView = STBottomToolBarView()
        return bottomTabbarView
        
    }()
    
    /// 删除这个组按钮
    fileprivate lazy var deleButton : UIButton = {
        let deleButton = UIButton()
        deleButton.setTitle("删除", for: .normal)
        deleButton.setTitleColor(.red, for: .normal)
        return deleButton
    }()
    lazy var label : UILabel = UILabel()
    
    // MARK:- 传递数据
    var connotationModelFrame : STConnotationModelFrame?{
        
        didSet{
            
            guard let connotationModelFrame = connotationModelFrame else{
                return
            }
            
            let type = connotationModelFrame.contentAndComment.type
            
            
            
            if type == ShowAD_NormalType.Normal.rawValue{
                guard let content = connotationModelFrame.contentAndComment.group else { return }
                
                let medioType = content.media_type
                
                switch medioType {
                case Media_type.Words.rawValue:
                    contentLabel.isHidden = false
                    photosView.isHidden = true
                    gifImageView.isHidden = true
                    videlView.isHidden = true
                    photosView.isHidden = true
                case Media_type.Picture_Words.rawValue:
                    contentLabel.isHidden = false
                    photosView.isHidden = false
                    gifImageView.isHidden = true
                    videlView.isHidden = true
                    photosView.isHidden = true
                case Media_type.GIF_Words.rawValue:
                    contentLabel.isHidden = false
                    photosView.isHidden = true
                    gifImageView.isHidden = false
                    videlView.isHidden = true
                    photosView.isHidden = true
                case Media_type.Video_Words.rawValue:
                    contentLabel.isHidden = false
                    photosView.isHidden = true
                    gifImageView.isHidden = true
                    videlView.isHidden = false
                    photosView.isHidden = true
                case Media_type.MorePicture_Words.rawValue:
                    contentLabel.isHidden = false
                    photosView.isHidden = true
                    gifImageView.isHidden = true
                    videlView.isHidden = true
                    photosView.isHidden = false
                default:
                    print("default")
                }
                
                bottomTabbarView.isHidden = false
                
            }
            else{
                photosView.isHidden = true
                videlView.isHidden = true
                gifImageView.isHidden = true
                photosView.isHidden = true
                bottomTabbarView.isHidden = true
            }
            
            setupFrame(connotationModelFrame)
            setupDate(connotationModelFrame)
            
        }
    }
    
    public var indexPath: IndexPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(needMoveView)
        needMoveView.addSubview(userInforView)
        userInforView.addSubview(userIconImageView)
        userInforView.addSubview(userNameLabel)
        userInforView.addSubview(userSubTitleLabel)
        needMoveView.addSubview(contentLabel)
        needMoveView.addSubview(categoryNameLabel)
        needMoveView.addSubview(pictureImageView)
        needMoveView.addSubview(gifImageView)
        needMoveView.addSubview(videlView)
        needMoveView.addSubview(photosView)
        needMoveView.addSubview(bottomTabbarView)
        contentView.addSubview(deleButton)
        
        addActions()
        
        
    }
    
    deinit {
        
        videlView.stop()
        print("stCell - 释放")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 添加事件
extension STCell {
    
     fileprivate func addActions(){
        
        deleButtonAction()
        
        categoryNameLabelAction()
    }
    
    // 删除按钮
    @objc fileprivate func deleButtonAction(){
        
        deleButton.addTarget(self, action: #selector(deleButtonClick), for: .touchUpInside)
    }
    
    // 分类手势
    @objc fileprivate func categoryNameLabelAction(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(STCell.categoryNameLabelTap))
        categoryNameLabel.addGestureRecognizer(tap)
        
    }
}

// MARK:- 事件执行
extension STCell {
    
    @objc fileprivate func deleButtonClick(){
        
        guard let indexPath = indexPath else { return }
        delegate?.deleGroup(self, connotationModelFrame,indexPath)
    }
    
    @objc fileprivate func categoryNameLabelTap(){
        
        let categoryVC = STCategoryViewController()
        categoryVC.category_id = connotationModelFrame?.contentAndComment.group?.category_id ?? 0
        let nav = getNavigation()
        nav.pushViewController(categoryVC, animated: true)
    }
}

extension STCell {
    
    fileprivate func setupFrame(_ connotationModelFrame : STConnotationModelFrame){
        needMoveView.frame = CGRect(x: 0, y: 0, width: sScreenW, height: connotationModelFrame.needMoveViewHeight)
        userInforView.frame = connotationModelFrame.userInforViewFrame
        userIconImageView.frame = connotationModelFrame.userIconFrame
        userNameLabel.frame = connotationModelFrame.userNameFrame
        contentLabel.frame = connotationModelFrame.contentLabelFrame
        
        categoryNameLabel.frame = connotationModelFrame.categoryNameViewFrame
        categoryNameLabel.layer.cornerRadius = connotationModelFrame.categoryNameViewFrame.height * 0.5
        
        
        pictureImageView.frame = connotationModelFrame.imageFrame
        gifImageView.frame = connotationModelFrame.gifFrame
        videlView.frame = connotationModelFrame.videoFrame
        photosView.frame = connotationModelFrame.thumbImageListFrame
        bottomTabbarView.frame = connotationModelFrame.bottomTabbarViewFrame
        deleButton.frame = connotationModelFrame.deleButtonFrame
    }
    
    fileprivate func setupDate(_ connotationModelFrame : STConnotationModelFrame){
        let connentAndComment = connotationModelFrame.contentAndComment
        let type = connentAndComment.type
        if type == ShowAD_NormalType.Normal.rawValue{
            guard let content = connotationModelFrame.contentAndComment.group else { return }
            guard let user = content.user else { return }
//            userIconImageView.kf.setImage(with: URL(string: user.avatar_url ?? ""))
            userIconImageView.iconImageURLString = user.avatar_url ?? ""
            userNameLabel.text = connotationModelFrame.userName
            contentLabel.attributedText = connotationModelFrame.contentAttributedString
            categoryNameLabel.text = content.category_name
            let url = URL(string: content.large_image?.url_list?.first?.url ?? "")
            pictureImageView.connotationModelFrame = connotationModelFrame
            //            gifImageView.kf.setImage(with: url)
            gifImageView.connotationModelFrame = connotationModelFrame
            videlView.connotationModelFrame = connotationModelFrame
            photosView.photos = connotationModelFrame.contentAndComment.group?.thumb_image_list
            bottomTabbarView.content = connotationModelFrame.contentAndComment.group
            
        }else{
            // 取出广告
            guard let ad = connentAndComment.ad else { return }
//            userIconImageView.kf.setImage(with: URL(string: ad.avatar_url))
            userIconImageView.iconImageURLString = ad.avatar_url
            userNameLabel.text = connotationModelFrame.userName
            contentLabel.text = ad.display_info
            let url = URL(string: ad.display_image)
            pictureImageView.connotationModelFrame = connotationModelFrame
        }
        
    }
    
}
