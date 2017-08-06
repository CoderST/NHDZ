//
//  STProgressView.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/7/30.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
import DACircularProgress
class STProgressView: DALabeledCircularProgressView {

    override func awakeFromNib() {
        roundedCorners = 2
        progressLabel.textColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        roundedCorners = 2
        progressLabel.textColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setProgress(_ progress: CGFloat, animated: Bool) {
        super.setProgress(progress, animated: animated)
        
        let text = String(format: "%.0f%%",progress * 100)
//        progressLabel.text = text.replacingOccurrences(of: "-", with: "")
//        print("text = \(text)")
        if progressLabel != nil{
            
            progressLabel.text = text
        }
    }
}
