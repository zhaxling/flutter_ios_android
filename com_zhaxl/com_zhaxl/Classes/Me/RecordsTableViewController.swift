//
//  RecordsTableViewController.swift
//  com_zhaxl
//
//  Created by ZXL on 2020/6/7.
//  Copyright © 2020 zxl. All rights reserved.
//

import UIKit

class RecordsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "记录"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        var childs = self.navigationController?.children
        for vc in childs! {
            if vc.isKind(of: InputViewController.self) {
                vc.removeFromParent()
                break
            }
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)


        return cell
    }
}
