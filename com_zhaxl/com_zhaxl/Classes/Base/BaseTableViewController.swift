//
//  BaseTableViewController.swift
//  com_music
//
//  Created by ZXL on 2020/5/28.
//  Copyright © 2020 zxl. All rights reserved.
//

import UIKit

class BaseTableViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.backgroundColor = UIColor.white
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        
    }
}
