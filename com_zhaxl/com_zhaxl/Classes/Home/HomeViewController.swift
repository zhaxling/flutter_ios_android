//
//  HomeViewController.swift
//  com_zhaxl
//
//  Created by ZXL on 2020/5/30.
//  Copyright © 2020 zxl. All rights reserved.
//

import UIKit
import Alamofire
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
        
        
        let titles = ["记账","记账","记账"]
        
        var butttonY = 350
        var tag = 10
        
        
        for str in titles {
            let btn = UIButton(frame: CGRect(x: 10, y: butttonY, width: Int(UIScreen.main.bounds.size.width) - 20, height: 38))
            btn.setTitle(str, for: .normal)
            btn.backgroundColor = UIColor.orange
            btn.tag = tag
            btn.addTarget(self, action: #selector(tapClick), for: .touchUpInside)
            view.addSubview(btn)
            butttonY = butttonY + 38 + 10
            tag = tag + 10
        }
    }
    
    @objc func tapClick(btn :UIButton) {
        
    }
    
    
}
