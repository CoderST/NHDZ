//
//  STShowPictureViewController.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/7/30.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
import SVProgressHUD
class STShowPictureViewController: UIViewController {

    
    fileprivate lazy var scrollView : UIScrollView = {
       
        let scrollView = UIScrollView()
        
        return scrollView
        
    }()
    
    fileprivate lazy var progressView : STProgressView = {
        
        let progressView = STProgressView()
        
        return progressView
        
    }()
    
    fileprivate lazy var imageView : UIImageView = {
        
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        return imageView
        
    }()
    
    fileprivate lazy var downLoadButton : UIButton = {
       
        let  downLoadButton = UIButton()
        downLoadButton.setTitle("下载", for: .normal)
        downLoadButton.backgroundColor = UIColor(white: 0.5, alpha: 0.8)
        return downLoadButton
    }()
    
    var connotationModelFrame : STConnotationModelFrame?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        view.addSubview(scrollView)
        view.addSubview(downLoadButton)
        view.addSubview(progressView)
        scrollView.addSubview(imageView)
        
        scrollView.frame = view.bounds
        imageView.frame = scrollView.bounds
        downLoadButton.frame = CGRect(x: sScreenW - 60, y: sScreenH - 60, width: 40, height: 40)
        progressView.frame = CGRect(x: (view.frame.width - progressViewWH) * 0.5, y: (view.frame.height - progressViewWH) * 0.5, width: progressViewWH, height: progressViewWH)
        
        downLoadButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(back))
        view.addGestureRecognizer(tap)
        
        let pictureW = sScreenW
        guard let connent = connotationModelFrame?.contentAndComment.group else { return }
        guard let largeImage = connent.large_image else { return }
         let pictureH = pictureW * CGFloat(largeImage.r_height) / CGFloat(largeImage.r_width)
        
        if pictureH > sScreenH{
            imageView.frame = CGRect(x: 0, y: 0, width: pictureW, height: pictureH)
            scrollView.contentSize = CGSize(width: 0, height: pictureH)
        }else{
            imageView.frame.size = CGSize(width: pictureW, height: pictureH)
            imageView.center.y = sScreenH * 0.5
        }
        
        let url = URL(string: largeImage.url_list?.first?.url ?? "")
        imageView.kf.setImage(with: url, placeholder: UIImage(named: "timeline_image_placeholder"), options: nil, progressBlock: { (receivedSize, expectedSize) in
            let progress = CGFloat(receivedSize / expectedSize)
                        self.progressView.setProgress(progress, animated: true)
//            SVProgressHUD.showProgress(Float(progress))

        }) { (image, error, cacheType, imageUrl) in
            self.progressView.isHidden = true
            
        }
}
    
    
    
    func back() {
        dismiss(animated: true, completion: nil)
    }
    
    func save() {
        
        if imageView.image == nil {
            SVProgressHUD.showError(withStatus: "没有下载完毕")
            return
        }
        let image = imageView.image!
        UIImageWriteToSavedPhotosAlbum(image,self,#selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    //保存图片回调
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        var resultTitle:String?
        var resultMessage:String?
        if error != nil {
            resultTitle = "错误"
            resultMessage = "保存失败,请检查是否允许使用相册"
        } else {
            resultTitle = "提示"
            resultMessage = "保存成功"
        }
        let alert:UIAlertController = UIAlertController.init(title: resultTitle, message:resultMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
