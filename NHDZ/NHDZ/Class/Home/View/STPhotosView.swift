//
//  STPhotosView.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/7/29.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
import SKPhotoBrowser
class STPhotosView: UIView {
    
    fileprivate lazy var images : [SKPhoto] = [SKPhoto]()
    fileprivate lazy var persentModel : PresentModel = PresentModel()
    var photos : [ThumbImage]?{
        
        didSet{
            
            guard let photos = photos else { return }
            
            let photoCount = photos.count
            while subviews.count < photoCount {
                let photoView = STPhotoImageView(frame: CGRect.zero)
                addSubview(photoView)
                // 添加手势
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
                photoView.addGestureRecognizer(tap)
            }
            images.removeAll()
            for i in 0..<subviews.count {
                
                guard let photoView = subviews[i] as? STPhotoImageView else { continue }
                photoView.tag = i
                if i < photoCount{
                    let thumbImage = photos[i]
                    let photo = SKPhoto.photoWithImageURL(thumbImage.url)
                    
                    photo.shouldCachePhotoURLImage = false
                    images.append(photo)
                    
                    photoView.thumbImage = thumbImage
                    photoView.isHidden = false
                }else{
                    photoView.isHidden = true
                }
                
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let photos = photos else { return }
        let photosCount = photos.count
        let maxCol = maxColCount(photosCount)
        for i in 0..<photosCount{
            let photoView = subviews[i]
            let col = i % maxCol
            let x = CGFloat(col) * (photoWH + photoMargin)
            
            let row = i / maxCol
            let y = CGFloat(row) * (photoWH + photoMargin)
            let width = photoWH
            let height = photoWH
            photoView.frame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
}

extension STPhotosView {
    
    func sizeWithCount(_ photosCount : Int)->CGSize{
        let maxCol = maxColCount(photosCount)
        
        let cols = (photosCount >= maxCol) ? maxCol : photosCount
        let phoroW = CGFloat(cols) * photoWH + CGFloat((cols - 1)) * photoMargin
        let rows = (photosCount + maxCol - 1) / maxCol
        let photoH = CGFloat(rows) * photoWH + CGFloat((rows - 1)) * photoMargin
        
        return CGSize(width: phoroW, height: photoH)
    }
    
    fileprivate func maxColCount(_ photosCount : Int)->Int{
        var col : Int = 0
        if photosCount == 4 {
            col = 2
        }else{
            
            col = 3
        }
        
        return col
    }
}

extension STPhotosView {
    
    func tapAction(_ tapGesture : UITapGestureRecognizer){
        guard let imageView = tapGesture.view as? STPhotoImageView else { return }
        
        let browser = SKPhotoBrowser(originImage: imageView.image ?? UIImage(), photos: images, animatedFromView: imageView)
        browser.initializePageIndex(imageView.tag)
        
//        let browser = SKPhotoBrowser(photos: images)
//        browser.initializePageIndex(imageView.tag)
        UIApplication.shared.keyWindow?.rootViewController?.present(browser, animated: true, completion: nil)
        
        
        //        presentViewController(browser, animated: true, completion: {})
        
        //        let photosVC = STPhotosViewController()
        //        photosVC.urlStringArray = urlStringArray
        //        photosVC.index = imageView.tag
        //        photosVC.modalPresentationStyle = .custom
        //        photosVC.transitioningDelegate = persentModel
        //        persentModel.presentedFrame = CGRect(x: 0, y: 0, width: sScreenW, height: sScreenH)
        //        persentModel.animationType = .scale
    }
}
