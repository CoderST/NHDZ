//
//  STCommentDiggUsersModelFrame.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/5.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit

class STCommentDiggUsersModelFrame: NSObject {

    var diggUsersModelHeight : CGFloat = 0
    
    var commentDiggUsersModel : STCommentDiggUsersModel
    
    init(_ commentDiggUsersModel : STCommentDiggUsersModel) {
        self.commentDiggUsersModel = commentDiggUsersModel
        super.init()
        diggUsersModelHeight = userIconHW + 2 * commentMargin
    }
}
