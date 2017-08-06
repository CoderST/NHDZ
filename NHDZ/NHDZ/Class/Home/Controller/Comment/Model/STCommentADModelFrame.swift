//
//  STCommentADModelFrame.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/5.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit

class STCommentADModelFrame: NSObject {

    var adModel : STCommentADModel
    
    
    var adImageViewFrame : CGRect = .zero
    var adContentLabelFrame : CGRect = .zero
    var adHeight : CGFloat = 0
    
    init(_ adModel : STCommentADModel) {
        self.adModel = adModel
        super.init()
        guard let ad = adModel.ad else { return }
        let imageWidth = CGFloat(ad.webview_width)
        let imageHeight = CGFloat(ad.webview_height)
        
        let resultImageViewWidth = sScreenW - 2 * commentMargin
        let resultImageViewHeight = resultImageViewWidth * imageHeight / imageWidth
        adImageViewFrame = CGRect(x: commentMargin, y: commentMargin, width: resultImageViewWidth, height: resultImageViewHeight)
        
        let adContent = ad.web_title
        let adContentSize = adContent.sizeWithFont(adTitleFont)
        adContentLabelFrame = CGRect(x: adImageViewFrame.origin.x, y: adImageViewFrame.maxY + margin, width: adContentSize.width, height: adContentSize.height)
        
        
        adHeight = adContentLabelFrame.maxY + commentMargin
    }
}
