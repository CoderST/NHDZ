//
//  STCellPictureView.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/7/30.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
import SVProgressHUD
class STCellPictureView: UIView {
    
    fileprivate lazy var imageView : UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
        
    }()
    
    fileprivate lazy var seeBigButton : UIButton = {
        
        let seeBigButton = UIButton()
        seeBigButton.setTitle("点击查看全图", for: .normal)
        seeBigButton.setTitleColor(.white, for: .normal)
        seeBigButton.backgroundColor = .gray
        return seeBigButton
        
    }()
    
    fileprivate lazy var progressView : STProgressView = {
        
        let progressView = STProgressView()
        
        return progressView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(progressView)
        addSubview(seeBigButton)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        imageView.addGestureRecognizer(tap)
    }
    
    var connotationModelFrame : STConnotationModelFrame?{
        
        didSet{
            
            guard let connotationModelFrame = connotationModelFrame else { return }
            let contentAndComment = connotationModelFrame.contentAndComment
            
            if contentAndComment.type == ShowAD_NormalType.Normal.rawValue {
                guard let content = connotationModelFrame.contentAndComment.group else { return }
                                progressView.setProgress(content.pictureProgress, animated: false)
//                SVProgressHUD.showProgress(Float(content.pictureProgress))
                var url : URL?
                if content.media_type == Media_type.Picture_Words.rawValue {
                    url = URL(string: connotationModelFrame.pictureString)
                }else if content.media_type == Media_type.GIF_Words.rawValue {
                    url = URL(string: connotationModelFrame.gifString)
                }
                
                imageView.kf.setImage(with: url, placeholder: UIImage(named: "timeline_image_placeholder"), options: nil, progressBlock: { (receivedSize, expectedSize) in
                    content.pictureProgress = CGFloat(receivedSize) / CGFloat(expectedSize)
                    self.progressView.setProgress(content.pictureProgress, animated: true)
                }, completionHandler: { (image, error, cacheType, imageUrl) in
                    self.progressView.isHidden = true
                    // 是大图 重新绘制
                    if content.isBigPicture == false{
                        return
                    }
                    // 开启图形上下文
                    UIGraphicsBeginImageContextWithOptions(connotationModelFrame.imageFrame.size, true, 0)
                    // 将下载完的image对象绘制到图形上下文
                    let width = connotationModelFrame.imageFrame.width
                    let imageWidth = image?.size.width ?? 0
                    let imageHeight = image?.size.height ?? 0
                    let height = width * imageHeight / imageWidth
                    image?.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
                    
                    self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
                    
                    UIGraphicsEndImageContext()
                })
                
                seeBigButton.isHidden = !content.isBigPicture
                
            }else{
                
                guard let ad = connotationModelFrame.contentAndComment.ad else { return }
                let urlString = ad.display_image
                guard let url = URL(string: urlString) else { return }
                imageView.kf.setImage(with: url)
                seeBigButton.isHidden = true
            }
            
            
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        progressView.frame = CGRect(x: (frame.width - progressViewWH) * 0.5, y: (frame.height - progressViewWH) * 0.5, width: progressViewWH, height: progressViewWH)
        seeBigButton.frame = CGRect(x: 0, y: frame.height - 40, width: frame.width, height: 40)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension STCellPictureView {
    
    func tapAction(){
        guard let connotationModelFrame = connotationModelFrame else { return }
        let contentAndComment = connotationModelFrame.contentAndComment
        
        if contentAndComment.type == ShowAD_NormalType.Normal.rawValue{
            clickPicture(connotationModelFrame)
        }else{
            
            clickAD(connotationModelFrame)
        }
        
    }
    
    fileprivate func clickPicture(_ connotationModelFrame : STConnotationModelFrame){
        let showImageVC = STShowPictureViewController()
        showImageVC.connotationModelFrame = connotationModelFrame
        UIApplication.shared.keyWindow?.rootViewController?.present(showImageVC, animated: true, completion: nil)
        
    }
    
    fileprivate func clickAD(_ connotationModelFrame : STConnotationModelFrame){
        print("点击了广告")
    }
}
