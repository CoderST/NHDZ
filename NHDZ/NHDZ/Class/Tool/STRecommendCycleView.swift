//
//  STRecommendCycleView.swift
//  NHDZ
//
//  Created by xiudou on 2017/8/8.
//  Copyright © 2017年 CoderST. All rights reserved.
//  轮播图

import UIKit
import SVProgressHUD
// MARK:- 常量
fileprivate let STRecommendCycleCellIdentifier = "STRecommendCycleCellIdentifier"
class STRecommendCycleView: UIView {

    // MARK:- 属性
    fileprivate var cycleTime : Timer?
    // MARK:- 控件属性
    fileprivate lazy var cyclePage : UIPageControl = {
       
        let cyclePage = UIPageControl()
        
        return cyclePage
    }()
    
    // collectionView
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        // 设置layout属性
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        // 默认值(如果改动可以添加代理方法)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        // 创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: sScreenW, height: 0), collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(STRecommendCycleCell.self, forCellWithReuseIdentifier: STRecommendCycleCellIdentifier)
        // 设置数据源
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView;
        
        }()

    
    
    var banners : [Banners]?{
        didSet{
            
            guard let models = banners else { return }
            if models.count == 0 {
                return
            }
            collectionView.reloadData()
            // 3.默认滚动到中间某一个位置
            let indexPath = IndexPath(item: models.count * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            // 设置pageControl
            cyclePage.numberOfPages = models.count
            
            // 定时器操作
            removeTime()
            addTime()
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        addSubview(cyclePage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        // 设置该控件不随着父控件的拉伸而拉伸
////        autoresizingMask = UIViewAutoresizing()
//        
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
        let layout = collectionView.collectionViewLayout as!UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
        cyclePage.frame = CGRect(x: 0, y: bounds.height - 20, width: bounds.width, height: 20)
    }

}


// MARK:- UICollectionViewDataSource
extension STRecommendCycleView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = (banners?.count ?? 0) * 10000
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cycleCell = collectionView.dequeueReusableCell(withReuseIdentifier: STRecommendCycleCellIdentifier, for: indexPath) as! STRecommendCycleCell
        let cycleModel = banners![indexPath.item % (banners?.count ?? 0)]
        cycleCell.banner = cycleModel
        return cycleCell
    }
    
}

// MARK:- UICollectionViewDelegate
extension STRecommendCycleView : UICollectionViewDelegateFlowLayout{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 设置pageControl
        let offset = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        let currentPage = Int(offset / scrollView.bounds.width) % (banners?.count ?? 1)
        cyclePage.currentPage = currentPage
    }
    

    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        removeTime()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTime()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        guard let banners = banners else  { return }
        let model = banners[indexPath.item % (banners.count)]
        let urlString = model.schema_url
//        let downUrlString = "https://itunes.apple.com/cn/app/id\(id)/"
        guard let downUrl = URL(string: urlString) else { return }
        if UIApplication.shared.canOpenURL(downUrl) == true{
            UIApplication.shared.openURL(downUrl)
        }else{
            SVProgressHUD.showError(withStatus: "url失效")
        }
        
        print("-----")
    }
}

// MARK:- 定时器相关
extension STRecommendCycleView {
    
    // 创建定时器
    fileprivate func addTime(){
        cycleTime = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTime!, forMode: RunLoopMode.commonModes)
    }
    
    fileprivate func removeTime(){
        cycleTime?.invalidate()
        cycleTime = nil
    }
    
    @objc fileprivate func scrollToNextPage(){
        // 获取当前的偏移量
        let offSet = collectionView.contentOffset.x
        // 即将要滚动的偏移量
        let newOffSet = offSet + collectionView.bounds.width
        // 开始滚动
        collectionView.setContentOffset(CGPoint(x: newOffSet, y: 0), animated: true)
    }
}

