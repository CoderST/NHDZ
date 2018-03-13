//
//  MessageViewController.swift
//  NHDZ
//
//  Created by xiudou on 2017/6/26.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
fileprivate let messageVCCellIdentifier = "messageVCCellIdentifier"
class MessageViewController: UIViewController {
    
    fileprivate lazy var messageModelArray : [STMessageModel] = [STMessageModel]()
    
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
        collectionView.register(STMessageVCCell.self, forCellWithReuseIdentifier: messageVCCellIdentifier)
        // 设置数据源
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView;
        
    }()
    
    /// 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "消息"
        view.backgroundColor = UIColor.randomColor()
        
        setupUI()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 获取本地是否已经登录
    }
}

extension MessageViewController{
    
    fileprivate func setupUI(){
        view.addSubview(collectionView)
    }
    
    fileprivate func setupData(){
        // 投稿互动
        let hudongModle = STMessageModel("interaction", "投稿互动",STInteractionVC())
        
        //        // 系统消息
        let xiaoxiModle = STMessageModel("systemmessage", "系统消息",STSystemMessageVC())
        //        // 粉丝关注
        let fansModle = STMessageModel("vermicelli", "粉丝关注",STFansVC())
        messageModelArray = [hudongModle,xiaoxiModle,fansModle]
        
        collectionView.reloadData()
    }
}

extension MessageViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return messageModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: messageVCCellIdentifier, for: indexPath) as! STMessageVCCell
        let messageModel = messageModelArray[indexPath.item]
        cell.messageModel = messageModel
        //         cell.contentView.backgroundColor = UIColor.randomColor()
        return cell
    }
}

extension MessageViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: sScreenW, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 如果登录接口保存了token 此处要做token逻辑判断 STRegisterVC界面
        let messageModel = messageModelArray[indexPath.item]
        // 获取目标控制器
        guard let descVC = messageModel.desclass as? UIViewController else { return }
        navigationController?.pushViewController(descVC, animated: true)
    }
}
