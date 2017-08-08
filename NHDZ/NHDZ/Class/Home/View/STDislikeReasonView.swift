//
//  STDislikeReasonView.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/3.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
let LRMargin : CGFloat = 60


fileprivate let collectionViewIdentifier = "collectionViewIdentifier"
class STDislikeReasonView: UIView {
    
    lazy var resultDislikeResonArray : NSMutableArray = NSMutableArray()
    
    // 顶部头
    fileprivate lazy var topLabel : UILabel = {
       
        let topLabel = UILabel()
        topLabel.text = "选择你不喜欢的理由"
        topLabel.textAlignment = .center
        topLabel.backgroundColor = UIColor.purple
        return topLabel
    }()
    
    // collectionView
    fileprivate lazy var collectionView : UICollectionView = {
        // 设置layout属性
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: layoutWidth, height: layoutHeight)
        // 默认值(如果改动可以添加代理方法)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        // 创建UICollectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        return collectionView;
        
    }()
    
    fileprivate lazy var bottomView : STDislikeBottomView = {
       
        let bottomView = STDislikeBottomView()
//        bottomView.backgroundColor = .yellow
        return bottomView
        
    }()


    var dislikeReasonFrame : STDislikeResonFrame?{
        
        didSet{
            guard let dislikeReasonFrame = dislikeReasonFrame else { return }
            
            topLabel.frame = dislikeReasonFrame.topLabelFrame
            collectionView.frame = dislikeReasonFrame.collecitonViewFrame
            bottomView.frame = dislikeReasonFrame.bottomViewFrame
            
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        addSubview(topLabel)
        addSubview(collectionView)
        addSubview(bottomView)
        
        collectionView.register(STDislikeResonCell.self, forCellWithReuseIdentifier: collectionViewIdentifier)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension STDislikeReasonView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return dislikeReasonFrame?.dislikeReasonArray.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewIdentifier, for: indexPath) as! STDislikeResonCell
        if let dislikeReason = dislikeReasonFrame?.dislikeReasonArray[indexPath.item]{
            cell.dislikeReason = dislikeReason
        }
        
        return cell
    }
}

extension STDislikeReasonView : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        guard let collectionViewCell = collectionView.cellForItem(at: indexPath) else { return }
        let cell = collectionViewCell as! STDislikeResonCell
        guard let dislikeReasonArray = dislikeReasonFrame?.dislikeReasonArray else { return }
        let dislikeReson = dislikeReasonArray[indexPath.item]
        let statusButton = cell.statusButton
        if  statusButton.isSelected == false{
            statusButton.isSelected = true
            addStatus(dislikeReson)
        }else{
            statusButton.isSelected = false
            removeStatus(dislikeReson)
        }
        
    }
}

extension STDislikeReasonView {
    
    fileprivate func addStatus(_ dislikeReson : Dislike_Reason){
 
        if resultDislikeResonArray.contains(dislikeReson) == false{
            resultDislikeResonArray.add(dislikeReson)
        }
 
        
    }
    
    fileprivate func removeStatus(_ dislikeReson : Dislike_Reason){
        if resultDislikeResonArray.contains(dislikeReson) == true{
            resultDislikeResonArray.remove(dislikeReson)
        }
    }
}
