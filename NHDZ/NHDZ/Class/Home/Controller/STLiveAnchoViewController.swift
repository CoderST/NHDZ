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
    fileprivate lazy var dismissButton : UIButton = {
       
        let button = UIButton(type: .contactAdd)
        
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(dismissButton)
        dismissButton.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        dismissButton.addTarget(self, action: #selector(dismissButtonAction), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    func dismissButtonAction(){
        
        dismiss(animated: true, completion: nil)
    }
}

extension STLiveAnchoViewController {
    
    func showDatasAndIndexPath(_ anchorFramelist : [STAnchorModelFrame], _ indexPath : IndexPath){
        self.anchorFramelist = anchorFramelist
        currentIndex = indexPath.item
    }
}
