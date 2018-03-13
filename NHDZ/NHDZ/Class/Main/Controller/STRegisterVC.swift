//
//  STRegisterVC.swift
//  NHDZ
//
//  Created by xiudou on 2018/3/13.
//  Copyright © 2018年 CoderST. All rights reserved.
//

import UIKit
fileprivate let registerVCCellIdentifier = "registerVCCellIdentifier"
class STRegisterVC: UIViewController {

    fileprivate lazy var registerArray : [STMessageModel] = [STMessageModel]()
    
    // collectionView
    fileprivate lazy var collectionView : UICollectionView = {
        // 设置layout属性
        let layout = UICollectionViewFlowLayout()
        let width = sScreenW
        // 默认值(如果改动可以添加代理方法)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        // 创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: sScreenW, height: sScreenH), collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .gray
        collectionView.register(STMessageVCCell.self, forCellWithReuseIdentifier: registerVCCellIdentifier)
        // 设置数据源
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView;
        
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "登录"
        
        view.backgroundColor = UIColor.randomColor()
        
        setupUI()
        setupData()
    }
}

extension STRegisterVC{
    
    fileprivate func setupUI(){
        view.addSubview(collectionView)
    }
    
    fileprivate func setupData(){
        // 投稿互动
//        STMessageModel(<#T##icon: String##String#>, <#T##name: String##String#>, <#T##desclass: AnyClass?##AnyClass?#>)
//                let hudongModle = STMessageModel("interaction", "投稿互动",)
        //        // 系统消息
        //        let xiaoxiModle = STMessageModel("systemmessage", "投稿互动")
        //        // 粉丝关注
        //        let fansModle = STMessageModel("vermicelli", "粉丝关注")
        //        messageModelArray = [hudongModle,xiaoxiModle,fansModle]
        
        collectionView.reloadData()
    }
}

extension STRegisterVC : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return registerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: registerVCCellIdentifier, for: indexPath) as! STMessageVCCell
        let messageModel = registerArray[indexPath.item]
        cell.messageModel = messageModel
        //         cell.contentView.backgroundColor = UIColor.randomColor()
        return cell
    }
}

extension STRegisterVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: sScreenW, height: cellHeight)
    }
}
