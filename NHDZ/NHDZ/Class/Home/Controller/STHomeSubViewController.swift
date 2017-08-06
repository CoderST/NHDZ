//
//  STHomeSubViewController.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/7/31.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
import SVProgressHUD
fileprivate let STCollectionViewCellIdentifier = "STCollectionViewCellIdentifier"
class STHomeSubViewController: STBaseViewController {

    var titleModel : TitleModle?
    
    fileprivate lazy var viewModel : STViewModel = STViewModel()
    
    // collectionView
    lazy var collectionView : UICollectionView = {
        // 设置layout属性
        let layout = UICollectionViewFlowLayout()
        let width = sScreenW
        // 默认值(如果改动可以添加代理方法)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        // 创建UICollectionView
        let collectionView = UICollectionView(frame:self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.gray
        return collectionView;
        
    }()

    
    override func viewDidLoad() {
        
        baseContentView = collectionView
        
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        // 2 绑定
        viewModel.bindViewModel(bindView: collectionView)
        
        // 3 添加数据
        guard let titleModel = titleModel else { return }
        viewModel.loaddatas(titleModel.list_id ,finishCallBack: {
            print(self.viewModel.connotationModelFrameArray.count)
            self.endAnimation()
            self.collectionView.reloadData()
            
        }) { (message) in
            
        }
        

    }

    
    deinit {
        print("STHomeSubViewController=\(titleModel?.name ?? "") - 销毁")
    }
}
