//
//  TestViewController.swift
//  NHDZ
//
//  Created by xiudou on 2017/8/7.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    fileprivate lazy var button : UIButton = {
       
        let button = UIButton()
        button.setTitle("返回", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        
        view.addSubview(button)
        
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
        button.addTarget(self, action: #selector(TestViewController.back), for: .touchUpInside)
    }
    
    
    func back(){
        
        dismiss(animated: true, completion: nil)
    }
}
