//
//  STRecommendCycleCell.swift
//  NHDZ
//
//  Created by xiudou on 2017/8/8.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit

class STRecommendCycleCell: UICollectionViewCell {
    
    fileprivate var cycleNameLabel : UILabel = {
       
        let cycleNameLabel = UILabel()
        cycleNameLabel.textColor = .white
        cycleNameLabel.font = userNameFont
        return cycleNameLabel
        
    }()
    
    fileprivate var cycleBackgroundImage : UIImageView = {
       
        let cycleBackgroundImage = UIImageView()
        cycleBackgroundImage.clipsToBounds = true
        cycleBackgroundImage.contentMode = .scaleAspectFit
        return cycleBackgroundImage
        
    }()
    
    var banner : Banners?{
        
        didSet{
            guard let banners = banner else  { return }
            let title = banners.banner_url?.title ?? ""
            cycleNameLabel.text = title
            let uri = banners.banner_url?.uri ?? ""
//            let urlString = "http://p3.pstatp.com/origin/\(uri)"
            let urlString = banners.banner_url?.url_list.first?.url ?? ""
            guard let url = URL(string: urlString) else  {return}
            cycleBackgroundImage.kf.setImage(with: url)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(cycleBackgroundImage)
        contentView.addSubview(cycleNameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cycleBackgroundImage.frame = bounds
        
        cycleNameLabel.sizeToFit()
        let height = cycleNameLabel.frame.height
        cycleNameLabel.frame = CGRect(x: 0, y: bounds.height - height, width: cycleNameLabel.frame.width, height: height)
    }
}
