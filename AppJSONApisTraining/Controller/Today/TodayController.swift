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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = #colorLiteral(red: 0.9274409003, green: 0.9274409003, blue: 0.9274409003, alpha: 1)
        
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: todayCellId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showSingleAppFullScreen(indexPath: indexPath)
    }
    
    fileprivate func showSingleAppFullScreen(indexPath: IndexPath) {
        // #1
        setupSingleAppFullscreenController(indexPath)
    }
    fileprivate func setupSingleAppFullscreenController(_ indexPath: IndexPath) {
        let appFullscreenController = UIViewController()
        appFullscreenController.view.backgroundColor = .red
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: todayCellId, for: indexPath)
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
