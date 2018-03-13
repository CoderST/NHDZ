//
//  STswift
//  NHDZ
//
//  Created by xiudou on 2018/3/12.
//  Copyright © 2018年 CoderST. All rights reserved.
//

import UIKit

class STNeedMoveView: UIView {
    
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
    fileprivate lazy var userInforView : UIView = {
        
        let userInforView = UIView()
                userInforView.backgroundColor = .yellow
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
    
//    /// 单个图片
//    fileprivate lazy var pictureImageView : STCellPictureView = {
//        
//        let pictureImageView = STCellPictureView()
//        return pictureImageView
//        
//    }()
//    /// gif图片
//    fileprivate lazy var gifImageView : STCellPictureView = {
//        
//        let gifImageView = STCellPictureView()
//        return gifImageView
//        
//    }()
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
//                    photosView.isHidden = true
//                    gifImageView.isHidden = true
                    videlView.isHidden = true
                    photosView.isHidden = true
                case Media_type.Picture_Words.rawValue:
                    contentLabel.isHidden = false
//                    photosView.isHidden = false
//                    gifImageView.isHidden = true
                    videlView.isHidden = true
                    photosView.isHidden = true
                case Media_type.GIF_Words.rawValue:
                    contentLabel.isHidden = false
//                    photosView.isHidden = true
//                    gifImageView.isHidden = false
                    videlView.isHidden = true
                    photosView.isHidden = true
                case Media_type.Video_Words.rawValue:
                    contentLabel.isHidden = false
//                    photosView.isHidden = true
//                    gifImageView.isHidden = true
                    videlView.isHidden = false
                    photosView.isHidden = true
                case Media_type.MorePicture_Words.rawValue:
                    contentLabel.isHidden = false
//                    photosView.isHidden = true
//                    gifImageView.isHidden = true
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
//                gifImageView.isHidden = true
//                photosView.isHidden = true
                bottomTabbarView.isHidden = true
            }
            
            setupFrame(connotationModelFrame)
            setupDate(connotationModelFrame)
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(userInforView)
        userInforView.addSubview(userIconImageView)
        userInforView.addSubview(userNameLabel)
        userInforView.addSubview(userSubTitleLabel)
        addSubview(contentLabel)       
        addSubview(categoryNameLabel)
//        addSubview(pictureImageView)
//        addSubview(gifImageView)
        addSubview(videlView)
        addSubview(photosView)
        addSubview(bottomTabbarView)
        
//        addActions()
        
        
    }
    
    deinit {
        
        videlView.stop()
        print("stCell - 释放")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension STNeedMoveView {
    
    fileprivate func setupFrame(_ connotationModelFrame : STConnotationModelFrame){
        userInforView.frame = connotationModelFrame.userInforViewFrame
        contentLabel.frame = connotationModelFrame.contentLabelFrame
        
        categoryNameLabel.frame = connotationModelFrame.categoryNameViewFrame
        categoryNameLabel.layer.cornerRadius = connotationModelFrame.categoryNameViewFrame.height * 0.5
        
        
        videlView.frame = connotationModelFrame.videoCommentFrame
        bottomTabbarView.frame = connotationModelFrame.bottomTabbarCommentViewFrame
    }
    
    fileprivate func setupDate(_ connotationModelFrame : STConnotationModelFrame){
        let connentAndComment = connotationModelFrame.contentAndComment
        let type = connentAndComment.type
        if type == ShowAD_NormalType.Normal.rawValue{
            guard let content = connotationModelFrame.contentAndComment.group else { return }
            guard let user = content.user else { return }
            contentLabel.attributedText = connotationModelFrame.contentAttributedString
            categoryNameLabel.text = content.category_name
            let url = URL(string: content.large_image?.url_list?.first?.url ?? "")
//            pictureImageView.connotationModelFrame = connotationModelFrame
//            //            gifImageView.kf.setImage(with: url)
//            gifImageView.connotationModelFrame = connotationModelFrame
            videlView.connotationModelFrame = connotationModelFrame
//            photosView.photos = connotationModelFrame.contentAndComment.group?.thumb_image_list
            bottomTabbarView.content = connotationModelFrame.contentAndComment.group
            
        }else{
            // 取出广告
            guard let ad = connentAndComment.ad else { return }
            contentLabel.text = ad.display_info
            let url = URL(string: ad.display_image)
//            pictureImageView.connotationModelFrame = connotationModelFrame
        }
        
    }
    
}
