//
//  DiscoverViewController.swift
//  NHDZ
//
//  Created by xiudou on 2017/6/26.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
fileprivate let STDiscoverCellIdentifier = "STDiscoverCellIdentifier"
class STDiscoverViewController: UIViewController {

    fileprivate lazy var discoverVM : STDiscoverVM = STDiscoverVM()
    
    fileprivate var newSize : CGSize = .zero
    
    /// 轮播图
    fileprivate lazy var rotateBannerView : STRecommendCycleView = {
        let rotateBanner = STRecommendCycleView()
        rotateBanner.backgroundColor = UIColor.orange
        rotateBanner.frame = CGRect(x: 0, y: -discoverRecommendCycleWH, width: sScreenW, height: 0)
        return rotateBanner
    }()

    
    // collectionView
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        // 设置layout属性
        let layout = UICollectionViewFlowLayout()
        let width = sScreenW
        // 默认值(如果改动可以添加代理方法)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        // 创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: NavAndStatusTotalHei, width: sScreenW, height: sScreenH - NavAndStatusTotalHei - TabbarHei), collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // 设置数据源
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.gray

        collectionView.backgroundColor = .white
        collectionView.register(STDiscoverCell.self, forCellWithReuseIdentifier: STDiscoverCellIdentifier)
        return collectionView;
        
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "发现"
        view.addSubview(collectionView)
        collectionView.addSubview(rotateBannerView)
        setupNav()
        setupData()
    }
}

extension STDiscoverViewController {
    
    fileprivate func setupNav(){
    
    let item = UIBarButtonItem(title: "🔍", style: .plain, target: self, action: #selector(searchPressed))
    navigationItem.leftBarButtonItem = item
    }
}

extension STDiscoverViewController{
    
    func searchPressed(){
        let h5VC = STDiscoverH5ViewController()
        h5VC.open_url = "http://lf.snssdk.com/neihan/search/essay/async/share/share"
        let nav = getNavigation()
        nav.pushViewController(h5VC, animated: true)
    }
}

extension STDiscoverViewController {
    
    fileprivate func setupData(){
        
        discoverVM.loadCategoryDatas({
            
            let size = self.discoverVM.bannerSize
            if self.newSize == .zero{
                self.rotateBannerView.frame = CGRect(origin: CGPoint(x: 0, y: -size.height), size: size)
                self.collectionView.contentInset = UIEdgeInsets(top: size.height, left: 0, bottom: 0, right: 0)
                self.newSize = size
            }
            self.rotateBannerView.banners = self.discoverVM.bannerArray
            self.collectionView.reloadData()
        }) { (message) in
            
        }
    }
}

extension STDiscoverViewController : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        print("numberOfItemsInSection",discoverVM.discoverFrameArray.count)
        return discoverVM.discoverFrameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: STDiscoverCellIdentifier, for: indexPath) as! STDiscoverCell
        let discoverFrame = discoverVM.discoverFrameArray[indexPath.item]
        print("cellForItemAt")
        cell.discoverFrame = discoverFrame
        return cell
    }
    
}

extension STDiscoverViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let discoverFrame = discoverVM.discoverFrameArray[indexPath.item]
        return CGSize(width: sScreenW, height: discoverFrame.cellHeight)
    }
}
