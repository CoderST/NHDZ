//
//  STCategoryViewController.swift
//  NHDZ
//
//  Created by xiudou on 2017/8/7.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit

class STCategoryViewController: STBaseViewController {

    fileprivate lazy var viewModel : STViewModel = STViewModel()
    fileprivate lazy var categoryVM : STCategoryVM = STCategoryVM()
    
    var category_id : Int = 0
    
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
        super.viewDidLoad()

        baseContentView = collectionView
        
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        // 2 绑定
        viewModel.bindViewModel(bindView: collectionView)
        
        // 3 添加数据
        categoryVM.loadCategoryDatas(category_id, { 
            self.viewModel.connotationModelFrameArray = self.categoryVM.connotationModelFrameArray
            self.collectionView.reloadData()
            self.endAnimation()
        }) { (message) in
            
        }
        
    }

    deinit {
        print("STCategoryViewController - 销毁")
    }
}
