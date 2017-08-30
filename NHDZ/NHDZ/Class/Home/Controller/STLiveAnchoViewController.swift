//
//  STLiveAnchoViewController.swift
//  NHDZ
//
//  Created by xiudou on 2017/8/16.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit

class STLiveAnchoViewController: UIViewController {
    
    fileprivate var currentIndex : Int = 0
    fileprivate var anchorFramelist : [STAnchorModelFrame] = [STAnchorModelFrame]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension STLiveAnchoViewController {
    
    func showDatasAndIndexPath(_ anchorFramelist : [STAnchorModelFrame], _ indexPath : IndexPath){
        self.anchorFramelist = anchorFramelist
        currentIndex = indexPath.item
    }
}
