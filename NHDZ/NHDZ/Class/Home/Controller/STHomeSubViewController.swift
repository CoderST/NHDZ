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
fileprivate let STAnchorCellIdentifier = "STAnchorCellIdentifier"
class STHomeSubViewController: STBaseViewController {
    
    var titleModel : TitleModle?
    
    fileprivate lazy var viewModel : STViewModel = STViewModel()
    fileprivate lazy var anchorviewModel : STAnchorViewModel = STAnchorViewModel()
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
        collectionView.backgroundColor = UIColor.white
        return collectionView;
        
    }()
    
    
    override func viewDidLoad() {
        
        baseContentView = collectionView
        
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        // 3 添加数据
        guard let titleModel = titleModel else { return }
        
        if titleModel.name == "直播" {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(STAnchorCell.self, forCellWithReuseIdentifier: STAnchorCellIdentifier)
            // 由于没有抓到直播接口,所以借用一下别的直播接口来充当画面效果
            anchorviewModel.getRoomAnchorData(1, finishCallBack: {
//                print(self.anchorviewModel.anchorlist.count)
                self.collectionView.reloadData()
                self.endAnimation()
                let time = STBaseVM.getUserDefaultsTime()
                print("time = \(time)")

            }, noDataCallBack: {
                
            })
            
            
        }else{
            
            
            // 2 绑定
            viewModel.bindViewModel(bindView: collectionView)
            
            viewModel.loaddatas(titleModel.list_id ,finishCallBack: {
                print("第一次加载",self.viewModel.connotationModelFrameArray.count)
                self.endAnimation()
                self.collectionView.reloadData()
                
            }) { (message) in
                
            }
        }
        
        
        
        // 4 添加下拉刷新
        setupRefsh()
        
    }
    
    
    deinit {
        print("STHomeSubViewController=\(titleModel?.name ?? "") - 销毁")
    }
}

extension STHomeSubViewController {
    
    func setupRefsh(){
        collectionView.mj_header = STRefreshGifHeader(refreshingTarget: self, refreshingAction: #selector(STHomeSubViewController.loadNewData))
    }
    
    func loadNewData(){
        guard let titleModel = titleModel else { return }
        viewModel.loaddatas(titleModel.list_id ,finishCallBack: {
            print("刷新数据了~~~~",self.viewModel.connotationModelFrameArray.count)

            self.collectionView.mj_header.endRefreshing()
            self.collectionView.reloadData()
            
        }) { (message) in
            
        }
        
    }
}

// MARK:- UICollectionViewDataSource
extension STHomeSubViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return anchorviewModel.anchorFramelist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: STAnchorCellIdentifier, for: indexPath) as! STAnchorCell
        let anchorFrame = anchorviewModel.anchorFramelist[indexPath.item]
        cell.anchorFrame = anchorFrame
        return cell
        
    }
    
}

// MARK:- UICollectionViewDelegateFlowLayout
extension STHomeSubViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let anchorFrame = anchorviewModel.anchorFramelist[indexPath.item]
        let size  = CGSize(width: sScreenW, height:  anchorFrame.cellHeight)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let anchorFramelist = anchorviewModel.anchorFramelist
        let liveVC = STLiveAnchoViewController()
//        liveVC.anchorFrame = anchorFrame
        // 1 判断数组是否有值
        if anchorFramelist.count == 0{
            return
        }
        // 2 传递数组和当前indexpath
        liveVC.showDatasAndIndexPath(anchorFramelist, indexPath)
        present(liveVC, animated: true, completion: nil)
    }
    
}

