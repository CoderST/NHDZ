//
//  STConnotationModelFrame.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/7/29.
//  Copyright © 2017年 CoderST. All rights reserved.
//
/*
 
 media_type 2 gif
 media_type 2 文字 gif
 
 media_type 3 视频
 media_type 3 文字 视频
 
 media_type 4 文字 多图片
 
 media_type 1 图片
 media_type 1 文字 图片
 
 media_type 0 热门 文字
 media_type 0 文字
 */
import UIKit
/// 可见视图区域
fileprivate let viewHeight = sScreenH - NavAndStatusTotalHei - TabbarHei
/// 可见视图比例系数
fileprivate let viewHeightScale : CGFloat = 2 / 3
/// 底部bottomtabbarview高度
fileprivate let bottomTabbarViewHeight : CGFloat = 49
fileprivate let maxSize = CGSize(width: sScreenW - 2 * margin, height: CGFloat(MAXFLOAT))
fileprivate let deleButtonWH : CGFloat = 40
enum ShowAD_NormalType : Int{
    case Normal = 1
    case AD = 5
}

enum Media_type : Int{
    case Words = 0  // 只有文字
    case Picture_Words = 1  // 图片或者图片和文字
    case GIF_Words = 2  // GIF或者GIF和文字
    case Video_Words = 3  // 视频或者视频和文字
    case MorePicture_Words = 4  // 多图片或者多图片和文字
}

class STConnotationModelFrame: NSObject {
    // MARK:- 对外数据
    var contentAndComment : ContentAndComment
    /// 用户名称
    var userName : String = ""
    /// 用户子标题
    var userSubTitle : String = ""
    /// 图片地址
    var pictureString : String = ""
    /// gif地址
    var gifString : String = ""
    /// 视频placehold
    var videoPlaceHoldString : String = ""
    /// 视频播放地址
    var videoString : String = ""
    /// 视频播放时长
    var videoPlayTime : Int = 0
    
    // MARK:- 对外尺寸
    /// 用户头像
    var userIconFrame : CGRect = .zero
    /// 用户名称
    var userNameFrame : CGRect = .zero
    /// 用户子标题
    var userSubTitleLabelFrame : CGRect = .zero
    /// 用户信息(包括上面信息)
    var userInforViewFrame : CGRect = .zero
    /// 内容
    var contentLabelFrame : CGRect = .zero
    /// 单个图片
    var imageFrame : CGRect = .zero
    /// gif图片
    var gifFrame : CGRect = .zero
    /// 视频
    var videoFrame : CGRect = .zero
    /// 多图View
    var thumbImageListFrame : CGRect = .zero
    /// 底部tabbar
    var bottomTabbarViewFrame : CGRect = .zero
    /// 以上控件的父控件(方便传递到评论,整体嫁接)
    var needMoveViewHeight : CGFloat = 0
    
    /// 删除组按钮
    var deleButtonFrame : CGRect = .zero
    /// cell高度
    var cellHeight : CGFloat = 0
    
    init(_ contentAndComment : ContentAndComment) {
        self.contentAndComment = contentAndComment
        super.init()
        // type 1 正常展示  type 5 广告
        
        
        let type = contentAndComment.type
        if type == ShowAD_NormalType.Normal.rawValue {  // 正常
            guard let content = contentAndComment.group else { return }
            // 计算头像和用户名称
            // 取出用户
            guard let user = content.user else { return }
            userIconFrame = CGRect(x: margin, y: margin, width: userIconHW, height: userIconHW)
            
            // 用户名称
            userName = user.name ?? ""
            let userNameSize = userName.sizeWithFont(userNameFont)
            userNameFrame = CGRect(x: userIconFrame.maxX + margin, y: userIconFrame.origin.y + (userIconFrame.height - userNameSize.height) * 0.5, width: userNameSize.width, height: userNameSize.height)
            
            // 子标题
            let ugcCount = user.ugc_count
            let fansCount = user.followers
            let ugc = String.countStringFrome(ugcCount)
            let fans = String.countStringFrome(fansCount)
            userSubTitle = "\(ugc)作品 \(fans)粉丝"
            let subStreingSize = userSubTitle.sizeWithFont(userSubTitleFont)
            userSubTitleLabelFrame = CGRect(x: userNameFrame.origin.x, y: userIconFrame.maxY - subStreingSize.height, width: subStreingSize.width, height: subStreingSize.height)
            
            userInforViewFrame = CGRect(x: 0, y: 0, width: sScreenW, height: userIconFrame.maxY)
            
            let mediaType = content.media_type
            switch mediaType {
            case Media_type.Words.rawValue:
                
                WordsAction(content)
                
            case Media_type.Picture_Words.rawValue:
                
                PictureWordsAction(content)
                
            case Media_type.GIF_Words.rawValue:
                
                GIFWordsAction(content)
                
            case Media_type.Video_Words.rawValue:
                
                VideoWordsAction(content)
                
            case Media_type.MorePicture_Words.rawValue:
                
                MorePictureWordsAction(content)
                
            default:
                print("ppppppppp-不知道的子类型")
            }
            
            bottomTabbarViewFrame = CGRect(x: 0, y: cellHeight, width: sScreenW, height: bottomTabbarViewHeight)
            cellHeight = bottomTabbarViewFrame.maxY
            needMoveViewHeight = cellHeight


        }else if type == ShowAD_NormalType.AD.rawValue{  // 广告
            // 取出用户 获取广告
            guard let ad = contentAndComment.ad else { return }
            userIconFrame = CGRect(x: margin, y: margin, width: userIconHW, height: userIconHW)
            
            // 用户名称
            //            let userNameString = ad.avatar_name
            userName = "广告"
            let userNameSize = userName.sizeWithFont(userNameFont)
            userNameFrame = CGRect(x: userIconFrame.maxX + margin, y: userIconFrame.origin.y + (userIconFrame.height - userNameSize.height) * 0.5, width: userNameSize.width, height: userNameSize.height)
            
            userInforViewFrame = CGRect(x: 0, y: 0, width: sScreenW, height: userIconFrame.maxY)
            
            ADPictureWordsAction(ad)
        }else{
            
            print("ppppppppp-不知道的类型")
        }
        
        deleButtonFrame = CGRect(x: sScreenW - deleButtonWH, y: 0, width: deleButtonWH, height: deleButtonWH)
        
        print("cellHeightmmmmmm = \(cellHeight)")
    }
}

// MARK:- 私有方法
extension STConnotationModelFrame {
    
    fileprivate func WordsAction(_ content : Content) {
        // 获取文本
        let title = content.text
        var titleSize : CGSize = .zero
        // 赋值尺寸
        var y : CGFloat = 0
        if title.characters.count > 0{
            // 字段宽高
            titleSize = title.sizeWithFont(titleFont, size: maxSize)
            y = userIconFrame.maxY + margin
        }else{
            y = userIconFrame.maxY
        }
        contentLabelFrame = CGRect(x: margin, y: y, width: titleSize.width, height: titleSize.height)
       
        
        cellHeight = contentLabelFrame.maxY + margin
        
    }
    
    fileprivate func PictureWordsAction(_ content : Content) {
        WordsAction(content)
        guard let largeImage = content.large_image else { return }
        
        if let largeUrl = largeImage.url_list?.first{
            pictureString = largeUrl.url
        }
        
        
        let resultSize = picHeight(content, CGFloat(largeImage.r_width), CGFloat(largeImage.r_height))
        
        
        imageFrame = CGRect(x: margin, y: contentLabelFrame.maxY + margin, width: resultSize.width, height: resultSize.height)
        cellHeight = imageFrame.maxY + margin
    }
    
    fileprivate func GIFWordsAction(_ content : Content) {
        WordsAction(content)
        guard let largeImage = content.large_image else { return }
        if let largeUrl = largeImage.url_list?.first{
            gifString = largeUrl.url
        }
        let resultSize = picHeight(content, CGFloat(largeImage.r_width), CGFloat(largeImage.r_height))
        
        gifFrame = CGRect(x: margin, y: contentLabelFrame.maxY + margin, width: resultSize.width, height: resultSize.height)
        cellHeight = gifFrame.maxY + margin
        
    }
    
    fileprivate func picHeight(_ content : Content, _ width : CGFloat, _ height : CGFloat)->CGSize{
        guard let largeImage = content.large_image else { return CGSize.zero}
        let resultWidth = maxSize.width
        let scaleHeight =  resultWidth * CGFloat(largeImage.r_height) / CGFloat(largeImage.r_width)
        
        var resultHeight : CGFloat = 0
        
        if scaleHeight > CellPictureMaxH {
            content.isBigPicture = true
//                        userName = "大大大大大大"
            print("大大大大大大",userName,resultHeight)
            resultHeight = CellPictureBreakH
        }else{
            resultHeight = scaleHeight
            content.isBigPicture = false
        }
        
        return CGSize(width: resultWidth, height: resultHeight)
    }
    
    fileprivate func VideoWordsAction(_ content : Content) {
        WordsAction(content)
        if let urlString = content.medium_cover?.url_list?.first?.url{
            videoPlaceHoldString = urlString
        }
        videoString = content.mp4_url
        videoPlayTime = Int(content.duration)
        var x : CGFloat = 0
        var resultWidth = sScreenW
        var resultHeight : CGFloat = 0
        let videoHieght = CGFloat(content.video_height)
        
        let height = videoHieght * resultWidth / CGFloat(content.video_width)
        resultHeight = height
        if height > CellVideoMaxH {
            resultHeight = CellVideoBreakH
            
            resultWidth = sScreenW
        }
        
        videoFrame = CGRect(x: 0, y: contentLabelFrame.maxY + margin, width: resultWidth, height: resultHeight)
        cellHeight = videoFrame.maxY + margin
    }
    
    fileprivate func MorePictureWordsAction(_ content : Content) {
        WordsAction(content)
        guard let thumb_image_list = content.thumb_image_list else { return }
        let photosView = STPhotosView()
        let photosViewSize = photosView.sizeWithCount(thumb_image_list.count)
        let point = CGPoint(x: margin, y: contentLabelFrame.maxY + margin)
        thumbImageListFrame = CGRect(origin: point, size: photosViewSize)
        cellHeight = thumbImageListFrame.maxY + margin
    }
    
    
    /// 广告
    fileprivate func ADPictureWordsAction(_ ad : AD) {
        if ad.display_image.characters.count > 0 {
            ADWordsAction(ad)
            let resultWidth = Int(sScreenW - 2 * margin)
            
            let imageWidth = ad.display_image_width
            let imageHeight = ad.display_image_height
            
            let resultHeight = resultWidth * imageHeight / imageWidth
            imageFrame = CGRect(x: margin, y: contentLabelFrame.maxY + margin, width: CGFloat(resultWidth), height: CGFloat(resultHeight))
            cellHeight = imageFrame.maxY + margin
            
        }
    }
    
    fileprivate func ADWordsAction(_ ad : AD){
        // 获取文本
        let title = ad.display_info
        var titleSize : CGSize = .zero
        // 赋值尺寸
        var y : CGFloat = 0
        if title.characters.count > 0{
            y = userIconFrame.maxY + margin
            // 字段宽高
            titleSize = title.sizeWithFont(titleFont, size: maxSize)
        }else{
            y = userIconFrame.maxY
        }
        contentLabelFrame = CGRect(x: margin, y: y, width: titleSize.width, height: titleSize.height)
        
    }
}











