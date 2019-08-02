//
//  TodayController.swift
//  AppJSONApisTraining
//
//  Created by Mai Le Duong on 8/1/19.
//  Copyright © 2019 Mai Le Duong. All rights reserved.
//

import UIKit

class TodayController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let todayCellId = "todayCellId"
    
    var items = [TodayItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        navigationController?.isNavigationBarHidden = true
        collectionView.backgroundColor = #colorLiteral(red: 0.9274409003, green: 0.9274409003, blue: 0.9274409003, alpha: 1)
        
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: todayCellId)
        
    }
    
    fileprivate func fetchData() {
        let dispathGroup = DispatchGroup()
        
        var topGrossingGroup: AppGroup?
        var gamesGroup: AppGroup?
        
        dispathGroup.enter()
        Service.shared.fetchTopFree { (appGroup, err) in
            topGrossingGroup = appGroup
            dispathGroup.leave()
        }
        dispathGroup.enter()
        Service.shared.fetchGames { (appGroup, err) in
            gamesGroup = appGroup
            dispathGroup.leave()
        }
        dispathGroup.notify(queue: .main) {
            print("finished fetching")
            
            self.items = [
                TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white),
                TodayItem.init(category: "Daily List", title: topGrossingGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white),
                
                TodayItem.init(category: "Daily List", title: gamesGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white),
                TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9838578105, green: 0.9588007331, blue: 0.7274674177, alpha: 1)),
            ]
            
            self.collectionView.reloadData()
        }
    }
    
    var appFullscreenController: AppFullscreenController!
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showSingleAppFullScreen(indexPath: indexPath)
    }
    
    fileprivate func showSingleAppFullScreen(indexPath: IndexPath) {
        // #1
        setupSingleAppFullscreenController(indexPath)
        
        // #2 setup fullscreen in its starting position
        setupAppFullscreenStartingPosition(indexPath)
        
        // #3 Begin animate
        beginAnimationAppFullscreen()
    }
    
    fileprivate func setupSingleAppFullscreenController(_ indexPath: IndexPath) {
        print("clicking into today cell:", indexPath)
        let appFullscreenController = AppFullscreenController()
        appFullscreenController.todayItem = items[indexPath.item]
        appFullscreenController.dismisHandler = {
            self.handleAppFullscreenDismissal()
        }
        appFullscreenController.view.layer.cornerRadius = 16
        self.appFullscreenController = appFullscreenController
    }
    
    fileprivate func setupAppFullscreenStartingPosition(_ indexPath: IndexPath) {
        let fullscreenView = appFullscreenController.view!
        view.addSubview(fullscreenView)
        addChild(appFullscreenController)
        setupStartingCellFrame(indexPath)
        guard let startingFrame = self.startingFrame else { return }
//        fullscreenView.frame = startingFrame
        
        self.anchoredConstraints = fullscreenView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0), size: .init(width: startingFrame.width, height: startingFrame.height))
        self.view.layoutIfNeeded()
        
    }
    var startingFrame: CGRect?
    var anchoredConstraints: AnchoredConstraints?
    
    fileprivate func setupStartingCellFrame(_ indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
    }
    fileprivate func beginAnimationAppFullscreen() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {

            self.anchoredConstraints?.top?.constant = 0
            self.anchoredConstraints?.leading?.constant = 0
            self.anchoredConstraints?.width?.constant = self.view.frame.width
            self.anchoredConstraints?.height?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded() //starts animation
            
            self.tabBarController?.tabBar.transform =  CGAffineTransform(translationX: 0, y: 100)
            guard let cell = self.appFullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeaderCell else { return }
            cell.layoutIfNeeded()
        }, completion: nil)
    }
    fileprivate func handleAppFullscreenDismissal() {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            print("handle dismissal when clicking close button")
            self.appFullscreenController.view.transform = .identity
            self.appFullscreenController.tableView.contentOffset = .zero
            
            
            guard let startingFrame = self.startingFrame else { return }
            
            self.anchoredConstraints?.top?.constant = startingFrame.origin.y
            self.anchoredConstraints?.leading?.constant = startingFrame.origin.x
            self.anchoredConstraints?.width?.constant = startingFrame.width
            self.anchoredConstraints?.height?.constant = startingFrame.height
            
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.transform = .identity
            
            guard let cell = self.appFullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeaderCell else { return }
            cell.closeButton.alpha = 0
            cell.todayCell.topConstaint.constant = 24
            cell.layoutIfNeeded()
            
        }) { _ in
            self.appFullscreenController.view.removeFromSuperview()
            self.appFullscreenController.removeFromParent()
        }
        
        
        
        
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: todayCellId, for: indexPath) as! TodayCell
        cell.todayItem = items[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    static let todayCellHeight: CGFloat = 500
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 64, height: TodayController.todayCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 0, bottom: 32, right: 0)
    }
    
}
