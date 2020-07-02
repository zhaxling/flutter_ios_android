//
//  MessageViewController.swift
//  com_zhaxl
//
//  Created by ZXL on 2020/7/1.
//  Copyright © 2020 zxl. All rights reserved.
//

import UIKit

class MessageViewController: BaseTableViewController {
    
    let cellID = "UITableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)

        WSManager.manager.connect()
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        WSManager.manager.disconect()
    }
}

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.textLabel?.text = "行 \(indexPath.row)"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        WSManager.manager.sendData()
    }
    
}
