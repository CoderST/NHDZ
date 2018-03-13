//
//  STDiggUsersView.swift
//  NHDZ
//
//  Created by xiudou on 2018/3/12.
//  Copyright © 2018年 CoderST. All rights reserved.
//

import UIKit
import Kingfisher
class STDiggUsersView: UIView {

    fileprivate lazy var userIconImageArray : [UIImageView] = [UIImageView]()
    fileprivate let iconImageView : UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.contentMode = .center
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = userIconHW * 0.5
        return iconImageView
        
    }()
    
    var usersModel : [Users]?{
        
        didSet{
            guard let usersModel = usersModel else { return }
            let userModelArray : [Users]
            if usersModel.count > 5{
                userModelArray = Array(usersModel[0...5])
            }else{
                userModelArray = usersModel
            }
            
            
            for (index, user) in userModelArray.enumerated(){
                let iconImageView = UIImageView()
                iconImageView.contentMode = .center
                iconImageView.clipsToBounds = true
                iconImageView.layer.cornerRadius = userIconHW * 0.5
                addSubview(iconImageView)
                let url = URL(string: user.avatar_url)
                iconImageView.kf.setImage(with: url)
                userIconImageArray.append(iconImageView)
                
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        for (index, imageView) in userIconImageArray.enumerated(){
            let x : CGFloat = margin + (userIconHW + 10) * CGFloat(index)
            let y : CGFloat = (frame.height - userIconHW) * 0.5
            imageView.frame = CGRect(x: x, y: y, width: userIconHW, height: userIconHW)
        }
        
    }
}
