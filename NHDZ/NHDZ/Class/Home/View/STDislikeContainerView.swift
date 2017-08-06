//
//  STDislikeContainerView.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/3.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
import SVProgressHUD
class STDislikeContainerView: UIView {

    fileprivate lazy var dislikeView : STDislikeReasonView = {
       
        let dislikeView = STDislikeReasonView()
        dislikeView.layer.cornerRadius = 5
        dislikeView.clipsToBounds = true
        return dislikeView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(r: 123, g: 123, b: 123, alpha: 0.5)
        addSubview(dislikeView)
        
            
            NotificationCenter.default.addObserver(self, selector: #selector(buttonClick), name: NSNotification.Name(rawValue: DislikeNSNotification), object: nil)
    }
    
    var contentAndComment : ContentAndComment?{
        
        didSet{
            guard let dislikeReasonArray = contentAndComment?.group?.dislike_reason else { return }
            
            let dislikeReasonFrame = STDislikeResonFrame(dislikeReasonArray)
            dislikeView.frame = CGRect(x: LRMargin, y: (frame.height - dislikeReasonFrame.viewHeight) * 0.5, width: dislikeReasonFrame.viewWidth, height: dislikeReasonFrame.viewHeight)

            dislikeView.dislikeReasonFrame = dislikeReasonFrame
            
        }
        
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
    }
    
    func dismiss() {
        removeFromSuperview()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension STDislikeContainerView  {
    @objc fileprivate func buttonClick(notifi : NSNotification) {
        guard let dict = notifi.userInfo else { return }
        guard let button = dict["button"] as? UIButton else { return }
        
        guard let title = button.titleLabel?.text else { return }
        
        if title == "确定" {
            print("确定")
            let reresultDislikeResonArrayon = dislikeView.resultDislikeResonArray
            if reresultDislikeResonArrayon.count == 0 {
                return
            }
            var dictArray : [[String : Any]] = [[String : Any]]()
            for dislikeReason in reresultDislikeResonArrayon{
                guard let dis = dislikeReason as? Dislike_Reason else { continue }
                var dict : [String : Any] = [String : Any]()
                dict["id"] = dis.ID
                dict["type"] = dis.type
                dictArray.append(dict)
            }
            if dislikeView.resultDislikeResonArray.count > 0 {
                sendDatas(dictArray, finishCallBack: { 
                    
                }, failCallBack: { (message) in
                    
                })
            }
        }else{
            dismiss()
            print("取消")
        }
        
    }
}

extension STDislikeContainerView {
    func sendDatas(_ reason : [[String : Any]], finishCallBack : @escaping ()->(), failCallBack : @escaping (_ message : String)->()){
        let urlString = "http://lf.snssdk.com/neihan/stream/dislike/?iid=11612214903&idfa=99F096BA-477A-4D0A-AB26-69B76DDB85C6&version_code=5.8.0&device_type=iPhone%205%20(Global)&live_sdk_version=130&os_version=8.4&screen_width=640&aid=7&vid=D5CDF3B6-1637-454E-B4BD-5CA1DF31E543&device_id=4598024398&os_api=18&app_name=joke_essay&device_platform=iphone&ac=WIFI&openudid=7881ad6e7d291af91681a760a49f1202e5954292&channel=App%20Store"
        guard let contentAndComment = contentAndComment else { return }
        guard let group = contentAndComment.group else { return }
        
        let content_type = contentAndComment.type_id
        let group_id = "\(group.group_id)"
        let reason = reason
        let parameters = ["content_type" : content_type, "group_id" : group_id, "reason" : reason] as [String : Any]
        NetworkTools.requestData(.post, URLString: urlString,parameters: parameters) { (result) in
            guard let resultDict = result as? [String : Any] else { return }
            
            guard let resultMessage = resultDict["message"] as? String else { return }
            self.dismiss()
            if resultMessage != "success"{
                SVProgressHUD.showSuccess(withStatus: resultMessage)
                failCallBack(resultMessage)
                return
            }
            
            SVProgressHUD.showSuccess(withStatus: "会减少类似推荐")
            /// 删除成功
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: DislikeSuccessNSNotification), object: self, userInfo: nil)
            
        }
        
    }
}
