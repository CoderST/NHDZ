//
//  STViewModel.swift
//  STPlayerExample
//
//  Created by xiudou on 2017/7/26.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
//import HandyJSON
import Alamofire

fileprivate let viewHeight = sScreenH - NavAndStatusTotalHei - TabbarHei
fileprivate let viewHeightScale : CGFloat = 2 / 3
public enum kScrollDerection: Int {
    
    case none
    
    case up // scroll up.
    
    case down // scroll down.
}
fileprivate let STCollectionViewCellIdentifier = "STCollectionViewCellIdentifier"
class STViewModel: NSObject,PlayProtocol {
    /// 数据
    var connotationModelFrameArray : [STConnotationModelFrame] = [STConnotationModelFrame]()
    /// collectionView
    fileprivate var collectionView : UICollectionView!
    /// 引用cell 获取当前的dislike indexpath
    fileprivate var dislikeIndexPath : IndexPath?
    
    // MARK:- 懒加载
    lazy var rangeToolModel : STPlayerToolModel = STPlayerToolModel()
    
    // MARK:- 网络请求
    func loaddatas(_ type : Int, finishCallBack : @escaping ()->(), failCallBack : @escaping (_ message : String)->()){
        //        let type = -104
        //        let latitude = arc4random_uniform(20) + 20
        //        let longitude = arc4random_uniform(20) + 40
        
        var urlString : String = ""
        if type == -104 {
            urlString = "http://lf.snssdk.com/neihan/stream/mix/v1/?content_type=\(type)&iid=11612214903&idfa=99F096BA-477A-4D0A-AB26-69B76DDB85C6&version_code=5.8.0&live_sdk_version=130&os_version=8.4&screen_width=640&aid=7&vid=D5CDF3B6-1637-454E-B4BD-5CA1DF31E543&content_type=\(type)&count=30&message_cursor=0&min_time=0&mpic=1"
        }else{
            urlString = "http://lf.snssdk.com/neihan/stream/mix/v1/?content_type=\(type)&iid=11612214903&idfa=99F096BA-477A-4D0A-AB26-69B76DDB85C6&version_code=5.8.0&device_type=iPhone%205%20(Global)&live_sdk_version=130&os_version=8.4&screen_width=640&aid=7&vid=D5CDF3B6-1637-454E-B4BD-5CA1DF31E543&device_id=4598024398&os_api=18&app_name=joke_essay&device_platform=iphone&ac=WIFI&openudid=7881ad6e7d291af91681a760a49f1202e5954292&channel=App%20Store&city=%E5%8C%97%E4%BA%AC%E5%B8%82&content_type=\(type)&count=30&essence=1&latitude=39.93562316915166&longitude=116.4325714110405&message_cursor=0&min_time=1501483384&mpic=1"
        }
        print("加载的URL = \(urlString)")
        
        NetworkTools.requestData(.get, URLString: urlString) { (result) in
            print("bbbbbb - \(type)")
            guard let resultDict = result as? [String : Any] else { return }
            
            guard let resultMessage = resultDict["message"] as? String else { return }
            
            if resultMessage != "success"{
                failCallBack(resultMessage)
                return
            }
            guard let dict = result as? NSDictionary else { return }
            
            if let object = STConnotationModel.deserialize(from: dict) {
                //                // 1 取出大的group
                guard let dataDict = object.data else { return }
                //
                // type 1 正常展示  type 5 广告
                let contentAndCommentArray = dataDict.data
                for contentAndComment in contentAndCommentArray {
                    contentAndComment.type_id = type
                    let modelFrame = STConnotationModelFrame(contentAndComment)
                    self.connotationModelFrameArray.append(modelFrame)
                }
                finishCallBack()
            }else{
                //
                failCallBack("没有解析出数据")
            }
            
            
        }
    }
    
    
    override init() {
        super.init()
        /// 通知
        setupNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("viewModel - 释放")
    }
}

// MARK:- 监听通知 - 通知方法
extension STViewModel {
    func setupNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(dislikeDelSuccess), name: NSNotification.Name(rawValue: DislikeSuccessNSNotification), object: nil)
    }
    
    
    @objc fileprivate func dislikeDelSuccess(notifi : NSNotification) {
        
        if dislikeIndexPath != nil {
            var indexPathArray : [IndexPath] = [IndexPath]()
            indexPathArray.append(dislikeIndexPath!)
            
            //  删除数据
            connotationModelFrameArray.remove(at: dislikeIndexPath!.item)
            /// 删除cell
            collectionView.deleteItems(at: indexPathArray)
            
        }
    }
    
}

extension STViewModel {
    
    // MARK:- 绑定
    func bindViewModel(bindView: UIView) {
        if bindView is UICollectionView{
            let collectionView = bindView as! UICollectionView
            self.collectionView = collectionView
            collectionView.dataSource = self
            collectionView.delegate = self
            // 注册cell
            collectionView.register(STCell.self, forCellWithReuseIdentifier: STCollectionViewCellIdentifier)
            
        }
    }
}

// MARK:- UICollectionViewDataSource
extension STViewModel : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return connotationModelFrameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        //        print(indexPath.item)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: STCollectionViewCellIdentifier, for: indexPath) as! STCell
        cell.contentView.backgroundColor = UIColor.randomColor()
        cell.indexPath = indexPath
        cell.delegate = self
        let connotationModelFrame = connotationModelFrameArray[indexPath.item]
        cell.connotationModelFrame = connotationModelFrame
        return cell
        
    }
    
}

// MARK:- UICollectionViewDelegateFlowLayout
extension STViewModel : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let connotationModelFrame = connotationModelFrameArray[indexPath.item]
        let size  = CGSize(width: sScreenW, height:  connotationModelFrame.cellHeight)
        print("size = \(size)")
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let connotationModelFrame = connotationModelFrameArray[indexPath.item]
        // 跳转评论
        let commentVC = STCommentViewController()
        commentVC.delegate = self
        
        /// 获取 cell中的videoView
        guard let cell = collectionView.cellForItem(at: indexPath) as? STCell else { return }
        
        let needMoveView = cell.needMoveView
        commentVC.connotationModelFrame = connotationModelFrame
        commentVC.needMoveView = needMoveView
        commentVC.indexPath = indexPath
        
        let nav = getNavigation()
        nav.pushViewController(commentVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: RemoveActionPlayer), object: cell)
        
        
    }
    
}

// MARK:- 代理 - STCellDelegate
extension STViewModel : STCellDelegate,STCommentViewControllerDelegate {
    
    func deleGroup(_ stCell: STCell, _ connotationModelFrame: STConnotationModelFrame?, _ indexPath: IndexPath) {
        dislikeIndexPath = indexPath
        // 弹出删除View
        let containerView = STDislikeContainerView()
        containerView.frame = CGRect(x: 0, y: 0, width: sScreenW, height: sScreenH)
        guard let connotationModelFrame = stCell.connotationModelFrame else { return }
        let contentAndComment = connotationModelFrame.contentAndComment
        containerView.contentAndComment = contentAndComment
        containerView.show()
    }
    
//    func backAction(_ commentViewController: STCommentViewController, _ needMoveView: UIView) {
//        
//    }
    func backAction(_ commentViewController: STCommentViewController, _ needMoveView: UIView, _ indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! STCell
        needMoveView.frame.origin.y = 0
        cell.contentView.addSubview(needMoveView)
        
    }
}

