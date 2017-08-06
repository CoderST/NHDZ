//
//  STCommentViewController.swift
//  STScrolPlay
//
//  Created by xiudou on 2017/8/4.
//  Copyright © 2017年 CoderST. All rights reserved.
//

import UIKit
fileprivate let cellCommentIdentifier = "cellCommentIdentifier"
fileprivate let STCommentReusableViewIdentifier = "STCommentReusableViewIdentifier"
protocol STCommentViewControllerDelegate : class{
    func backAction(_ commentViewController : STCommentViewController, _ needMoveView : UIView, _ indexPath : IndexPath)
}
class STCommentViewController: UIViewController {

    fileprivate lazy var commentVM : STCommentVM = STCommentVM()
    
    var connotationModelFrame : STConnotationModelFrame?
    var needMoveView : UIView?
    var indexPath : IndexPath?
    weak var delegate : STCommentViewControllerDelegate?
    
    /// 记录滚动的临界点
    fileprivate var scrollowOffY : CGFloat = 0
    /// 记录needMoveView的frame
    fileprivate var needMoveViewOriginalFrame : CGRect = .zero
    /// 动画时间
    fileprivate let transitionDuration : TimeInterval = 0.4
    /// 是否缩放完成
    fileprivate var isScaleComplete : Bool = false
    
    fileprivate lazy var backButton : UIButton = {
       
        let backButton = UIButton()
        backButton.backgroundColor = .red
        return backButton
    }()
    
    // collectionView
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        // 设置layout属性
        let layout = XDPlanFlowLayout()
        layout.naviHeight = 0
        let width = sScreenW
        // 默认值(如果改动可以添加代理方法)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.headerReferenceSize = CGSize(width: sScreenW, height: 30)
        // 创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: NavAndStatusTotalHei, width: sScreenW, height: sScreenH - NavAndStatusTotalHei - TabbarHei), collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        collectionView.register(STCommentCell.self, forCellWithReuseIdentifier: cellCommentIdentifier)
        collectionView.register(STCommentReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: STCommentReusableViewIdentifier)

        
        // 设置数据源
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.gray
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

//        collectionView.reg
        return collectionView;
        
    }()
    
    fileprivate lazy var diggUsersView : UIView = {
       
        let diggUsersView = UIView()
        diggUsersView.backgroundColor = UIColor.orange
        return diggUsersView
    }()
    
    fileprivate lazy var adView : STADView = {
        
        let adView = STADView()
        adView.backgroundColor = UIColor.red

        return adView
    }()
    
    override func viewDidLoad() {
        
       
        view.addSubview(collectionView)
        collectionView.addSubview(diggUsersView)
        collectionView.addSubview(adView)
        collectionView.addSubview(needMoveView!)
        
        
        guard let needMoveView = needMoveView else { return }
        print(needMoveView.frame)
        needMoveView.backgroundColor = UIColor.blue
        let needMoveViewHeight = needMoveView.frame.height
        let collectionTop = needMoveViewHeight
        needMoveView.frame.origin.y = -(needMoveViewHeight)
        /// 保存needMoveViewFrame
        needMoveViewOriginalFrame = CGRect(origin: CGPoint(x: needMoveView.frame.origin.x, y: needMoveView.frame.origin.y), size: needMoveView.frame.size)
        collectionView.contentInset = UIEdgeInsets(top: collectionTop, left: 0, bottom: 0, right: 0)

        
        
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = .white
        
        view.addSubview(backButton)
        backButton.frame = CGRect(x: 100, y: sScreenH - 80, width: 40, height: 40)
        backButton.addTarget(self, action: #selector(STCommentViewController.back), for: .touchUpInside)

        let back = UIBarButtonItem(customView: backButton)
        
        navigationItem.leftBarButtonItem = back

        
        setupData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        STPlayerManageAPI.removeAll()

    }
    
    func back(){
        guard let needMoveView = needMoveView else { return }
//        needMoveView.frame = needMoveViewOriginalFrame
        resetAnimation()
        delegate?.backAction(self, needMoveView,indexPath!)
        
        navigationController?.popViewController(animated: true)
    }

    deinit {
        print("STCommentViewController - 销毁")
    }
}

extension STCommentViewController {
    
    func setupData() {
        let userID = connotationModelFrame?.contentAndComment.group?.user?.user_id ?? 0
        let groupID = connotationModelFrame?.contentAndComment.group?.group_id ?? 0
        commentVM.loadUserAndDiggUsersAndComments("\(userID)", group_id: "\(groupID)", { 
            self.collectionView.reloadData()
            var collectionViewTop : CGFloat = 0
            // 1 广告 可有可无
            var adViewHeight : CGFloat = 0
            if let adModelFrame = self.commentVM.adModelFrame{
                collectionViewTop = adModelFrame.adHeight
                adViewHeight = adModelFrame.adHeight
                self.adView.commentADModelFrame = adModelFrame
            }else{
                collectionViewTop = 0
                adViewHeight = 0
            }
            self.adView.frame = CGRect(x: 0, y: -adViewHeight, width: sScreenW, height: adViewHeight)
            
            
            // 2 赞 踩 评论 分享条
            var diggViewHeight : CGFloat = 0
            if let diggUsersModelFrame = self.commentVM.diggUsersModelFrame {
                //            diggTop = needMoveView.frame.maxY
                collectionViewTop = collectionViewTop + diggUsersModelFrame.diggUsersModelHeight
                diggViewHeight = diggUsersModelFrame.diggUsersModelHeight
            }else{
                //            diggTop = needMoveView.frame.maxY + commentMargin
                collectionViewTop = collectionViewTop + 0
                diggViewHeight = 0
                
            }
            
            self.diggUsersView.frame = CGRect(x: 0, y: -collectionViewTop, width: sScreenW, height: diggViewHeight)
            
             // 3 设置needView
            
            collectionViewTop = collectionViewTop + self.needMoveView!.frame.height
            self.needMoveView?.frame.origin.y = -collectionViewTop
            
            // 4 评论 (热门,新鲜)
            
            self.collectionView.contentInset = UIEdgeInsets(top: collectionViewTop, left: 0, bottom: 0, right: 0)
            
//            print(self.collectionView.contentOffset.y)
            self.collectionView.contentOffset.y = -collectionViewTop

            // 5 记录临界点
            self.scrollowOffY = -(self.diggUsersView.frame.height + self.adView.frame.height)
            self.needMoveViewOriginalFrame = CGRect(origin: CGPoint(x: self.needMoveView!.frame.origin.x, y: self.collectionView.contentOffset.y), size: self.needMoveView!.frame.size)
        }) { (message) in
            print("message = \(message)")
        }
    }
}

extension STCommentViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        
        return commentVM.commentSectionDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        let section = commentVM.commentSectionDatas[section]
        
        return section.commentSectionModelFrame.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellCommentIdentifier, for: indexPath) as! STCommentCell

        cell.contentView.backgroundColor = UIColor.randomColor()
//
//        cell.indexPath = indexPath
        let commentGroup = commentVM.commentSectionDatas[indexPath.section]
        let commentFrame = commentGroup.commentSectionModelFrame[indexPath.item]
        cell.commentFrame = commentFrame
        return cell
    }

}

extension STCommentViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let commentGroup = commentVM.commentSectionDatas[indexPath.section]
        let commentFrame = commentGroup.commentSectionModelFrame[indexPath.item]
        return CGSize(width: sScreenW, height: commentFrame.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        // 1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: STCommentReusableViewIdentifier, for: indexPath) as!STCommentReusableView
        let commentGroup = commentVM.commentSectionDatas[indexPath.section]
        headerView.title = commentGroup.sectionTitle
        return headerView
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        //
        let offsetY = scrollView.contentOffset.y
        if offsetY > scrollowOffY {
            // 缩小动画
            if isScaleComplete == false {
                print("bbbbbbbbb-11111111111")
                
                isScaleComplete = true
                scaleAnimation()
            }
        }else{
            // 复位动画
            if isScaleComplete == true {
                print("bbbbbbbbb-22222222222")
                
                isScaleComplete = false
                resetAnimation()
            }
        }
    }
}

extension STCommentViewController {
    
    fileprivate func scaleAnimation(){
        guard let needMoveView = needMoveView else { return }
        view.addSubview(needMoveView)
        let scale : CGFloat = 0.3
        let scaleWidth = needMoveView.frame.width * scale
        let scaleHeight = needMoveView.frame.height * scale
        let scaleX = sScreenW - scaleWidth
        let scaleY : CGFloat = 64

        
        needMoveView.transform = CGAffineTransform(scaleX: 1, y: 1)
        UIView.animate(withDuration: transitionDuration, delay: 0, options: .allowAnimatedContent, animations: {
            needMoveView.transform = CGAffineTransform(scaleX: scale, y: scale)
            needMoveView.frame.origin.x = scaleX
            needMoveView.frame.origin.y = 64
//            needMoveView.frame = CGRect(x: scaleX, y: scaleY, width: scaleWidth, height: scaleHeight)
        }) { (isFinish) in
            
            print("缩小完成")
            
            
            
        }

    }
    
    fileprivate func resetAnimation(){
        guard let needMoveView = needMoveView else { return }
        collectionView.addSubview(needMoveView)

        
        needMoveView.transform = CGAffineTransform.identity
        print(needMoveView.frame)
        needMoveView.frame = needMoveViewOriginalFrame
        print(needMoveView.frame)
    }
}
