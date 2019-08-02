//
//  AppFullscreenController.swift
//  AppJSONApisTraining
//
//  Created by Mai Le Duong on 8/1/19.
//  Copyright © 2019 Mai Le Duong. All rights reserved.
//

import UIKit

class AppFullscreenController: UITableViewController {
    
    var todayItem: TodayItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        cell.backgroundColor = .red
        
        let headercell = AppFullscreenHeaderCell()
//        headercell.todayCell.
        headercell.todayCell.todayItem = todayItem
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TodayController.todayCellHeight
    }
}
