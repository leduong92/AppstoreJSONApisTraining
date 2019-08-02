//
//  AppFullscreenController.swift
//  AppJSONApisTraining
//
//  Created by Mai Le Duong on 8/1/19.
//  Copyright © 2019 Mai Le Duong. All rights reserved.
//

import UIKit

class AppFullscreenController: UITableViewController {
    
    var dismisHandler: (() -> ())?
    var todayItem: TodayItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        let height = UIApplication.shared.statusBarFrame.height
        tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        cell.backgroundColor = .red
        
        let headercell = AppFullscreenHeaderCell()
        headercell.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        headercell.todayCell.todayItem = todayItem
        
        
        return headercell
    }
    
    @objc fileprivate func handleDismiss(button: UIButton) {
        print("clicking close button")
        button.isHidden = true
        dismisHandler?()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TodayController.todayCellHeight
    }
}
