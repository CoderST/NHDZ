//
//  STConnotationModel.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/7/27.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
import HandyJSON
/// 可见视图区域
fileprivate let viewHeight = sScreenH - NavAndStatusTotalHei - TabbarHei
/// 可见视图比例系数
fileprivate let viewHeightScale : CGFloat = 2 / 3
class STConnotationModel: HandyJSON {

    var message: String = ""
    
    var data: DataDict?
    
    required init() {}
    
    
}
class DataDict: HandyJSON {
    
    var has_more: Bool = false
    
    var min_time: Int = 0
    
    var has_new_message: Bool = false
    
    var max_time: Double = 0
    
    var data: [ContentAndComment] = [ContentAndComment]()
    
    var tip: String = ""
    
    required init() {}
   
}

// MARK:- 内容和评论
class ContentAndComment : HandyJSON {
    var type_id : Int = 0
    var group: Content?
    
    var display_time: Int = 0
    
    var type: Int = 0
    
    var online_time: Int = 0
    
    var comments: [String]?
    
    var ad : AD?
    
    required init() {}
    
}

class AD : HandyJSON {
    var avatar_url : String = ""
    var avatar_name : String = ""
    var display_info : String = ""
    var title : String = ""
    var display_image : String = ""
    var display_image_width : Int = 0
    var display_image_height : Int = 0
    required init() {}
}

// MARK:- 内容
class Content: HandyJSON {
    
    var user_favorite: Int = 0
    
    var user: User?
    /// 图片下载进度
    var pictureProgress : CGFloat = 0
    var isBigPicture : Bool = false
    
//    var publish_time: String = ""
//    
//    var uri: String = ""
//    
//    var ID: Int = 0
    
//    var origin_video: Origin_Video?
    
//    var play_count: Int = 0
//    
//    var display_type: Int = 0
//    
    /// 组ID
    var group_id: Int = 0
//
//    var category_visible: Bool = false
//    
//    var title: String = ""
//    
//    var flash_url: String = ""
//    
//    var user_repin: Int = 0
//    
//    var cover_image_uri: String = ""
//    
//    var status_desc: String = ""
//    
//    var status: Int = 0
    
    var dislike_reason: [Dislike_Reason]?
    
//    var repin_count: Int = 0
//    
//    var cover_image_url: String = ""
//    
    /// 赞
    var digg_count: Int = 0
//
    /// 分享
    var share_count: Int = 0
//
//    var type: Int = 0
//    
//    var neihan_hot_start_time: String = ""
//    
//    var is_video: Int = 0
//    
//    var has_hot_comments: Int = 0
//    
    /// 评论数
    var comment_count: Int = 0
//
//    var go_detail_count: Int = 0
//    
//    var favorite_count: Int = 0
    
    /// 大图
    var large_cover: Large_Cover?
    
    /// 内容
    var text: String = ""
//    
//    var online_time: Int = 0
//  
    /// 分类ID
    var category_id: Int = 0
    /// 分类名称
    var category_name: String = ""
//
//    var download_url: String = ""
//    
//    var create_time: Int = 0
//    

//
//    var user_digg: Int = 0
//    
//    var category_type: Int = 0
//    
//    var share_url: String = ""
//    
//    var is_anonymous: Bool = false
//    
//    var quick_comment: Bool = false
//    
    /// 踩
    var bury_count: Int = 0
//
    
    var media_type: Int = 0
    var middle_image : middleImage?
    /// 大图
    var large_image : largeImage?
    /// 多图
    var thumb_image_list : [ThumbImage]?
//
//    var user_bury: Int = 0
    
    var medium_cover: Medium_Cover?
    
//    var share_type: Int = 0
//    
    var duration: Double = 0
    
//    var video480p : Video_480P?
//    
//    var video360p: Video_360P?
//    
//    var video720p: Video_720P?
    
//    var is_public_url: Int = 0
//    
//    var content: String = ""
//    
//    var video_id: String = ""
//    
//    var neihan_hot_end_time: String = ""
//    
//    var is_can_share: Int = 0
//    
//    var is_neihan_hot: Bool = false
    
    var mp4_url: String = ""
    
//    var has_comments: Int = 0
//    
//    var keywords: String = ""
//    
//    var m3u8_url: String = ""
//    
//    var label: Int = 0
//    
//    var id_str: String = ""
//    
//    var allow_dislike: Bool = false
    
//    var danmaku_attrs: Danmaku_Attrs?
    
    var video_width: Int = 0
    
    var video_height: Int = 0
    /// 视频尺寸
    var videoWidth: Int = 0
    var videoHeight: Int = 0
    
    required init() {}
    
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "large_cover" {
//            guard let valueDict = value as? [String : Any] else { return }
//            large_cover = Large_Cover(dict: valueDict)
//            
//        }else{
//            print("kkkkkkk \(key)\(value)")
//            setValue(value, forUndefinedKey: key)
//        }
//    }
    
   
    
}

class middleImage : HandyJSON {
    var r_width: Int = 0
    var r_height: Int = 0
    var url_list: [UrlList]?
    required init() {}
}

class largeImage : HandyJSON {
    var r_width: Int = 0
    var r_height: Int = 0
    var url_list: [UrlList]?
    required init() {}

}

class ThumbImage : HandyJSON {
    
    var url : String = ""
    var height : Int = 0
    var width : Int = 0
    var is_gif : Bool = false
    
    required init() {}
}

class Large_Cover: HandyJSON {
    
    var url_list: [UrlList]?
    
    var uri: String?
    
    required init() {}

   
}
class User: HandyJSON {
    
    var user_verified: Bool = false
    
    var ugc_count: Int = 0
    
    var is_following: Bool = false
    
    var followers: Int = 0
    
    var user_id: Int = 0
    
    var followings: Int = 0
    
    var is_pro_user: Bool = false
    
    var name: String?
    
    var avatar_url: String?
    required init() {}
}

class Medium_Cover: HandyJSON {
    
    var url_list: [UrlList]?
    
    var uri: String?
    
    required init() {}
}

class Dislike_Reason: HandyJSON {
    
    var type: Int = 0
    
    var ID: Int = 0
    
    var title: String?
    required init() {}
}

class UrlList: HandyJSON {
//    print("mp4_url = UrlList")
    var url: String = ""
    required init() {}
}

class Video_480P: NSObject {
    
    var url_list: [UrlList]?
    
    var width: Int = 0
    
    var uri: String?
    
    var height: Int = 0
    
}

class Danmaku_Attrs: BaseModel {
    
    var allow_send_danmaku: Int = 0
    
    var allow_show_danmaku: Int = 0
    
}

class Origin_Video: BaseModel {
    
    var url_list: [UrlList]?
    
    var width: Int = 0
    
    var uri: String?
    
    var height: Int = 0
    
}


class Video_720P: BaseModel {
    
    var url_list: [UrlList]?
    
    var width: Int = 0
    
    var uri: String?
    
    var height: Int = 0
    
}



class Video_360P: BaseModel {
    
    var url_list: [UrlList]?
    
    var width: Int = 0
    
    var uri: String?
    
    var height: Int = 0
    
}





