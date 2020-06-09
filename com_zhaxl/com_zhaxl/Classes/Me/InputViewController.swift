//
//  InputViewController.swift
//  com_zhaxl
//
//  Created by ZXL on 2020/6/7.
//  Copyright © 2020 zxl. All rights reserved.
//

import UIKit

class InputViewController: BaseViewController {
    
    var index:Int = 0
    

    @IBOutlet weak var moneyTF: UITextField!
    @IBOutlet weak var reasonTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "\(index)"
    }

    @IBAction func commitAction(_ sender: Any) {
        let vc = RecordsTableViewController()
        self.navigationController?.pushViewController(vc)
    }
    
    
}
