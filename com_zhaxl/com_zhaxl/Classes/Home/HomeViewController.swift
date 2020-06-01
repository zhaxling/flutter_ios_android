//
//  HomeViewController.swift
//  com_zhaxl
//
//  Created by ZXL on 2020/5/30.
//  Copyright © 2020 zxl. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwifterSwift

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stackView = UIStackView(frame: CGRect(x: 10, y: 100, width: 50, height: 200))
        stackView.backgroundColor = UIColor.white
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 5.0
        stackView.distribution = .equalCentering
        view.addSubview(stackView)
        
        let arr = ["1","2","3","4","5"]
        var Y = 0
        
        for str in arr {
            let label = UILabel(frame: CGRect(x: 0, y: Y, width: 50, height: 20))
            Y = Y + 20
            label.text = str
            label.backgroundColor = Color.random
            stackView.addArrangedSubview(label)
            if str == "4" {
                label.isHidden = true
                stackView.removeArrangedSubview(label)
            }
        }
        
        stackView.height = CGFloat(stackView.arrangedSubviews.count) * 25.0
        
    }
    
    
}
