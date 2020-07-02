//
//  MeViewController.swift
//  com_zhaxl
//
//  Created by ZXL on 2020/6/7.
//  Copyright © 2020 zxl. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import WebKit

class MeViewController: BaseViewController {
    
    let ScreenWidth = UIScreen.main.bounds.size.width
    let ScreenHeight = UIScreen.main.bounds.size.height
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton()
        btn.frame = CGRect(x: ScreenWidth * 0.25, y: ScreenHeight * 0.6, width: ScreenWidth * 0.5, height: ScreenWidth * 0.1)
        btn.setTitle("消息", for: .normal)
        btn.backgroundColor = UIColor.orange
        btn.addTarget(self, action: #selector(tapClick), for: .touchUpInside)
//        btn.layer.cornerRadius = ScreenWidth * 0.25
        view.addSubview(btn)
    }
    
    @objc func tapClick(btn :UIButton) {
//        let vc = MessageViewController()
//
//        self.navigationController?.pushViewController(vc)
        
        // http://127.0.0.1:8848/com_zxl_html/html/iosmessage.html
//        let vc = BaseWebViewController(urlString: "http://127.0.0.1:8848/com_zxl_html/html/iosmessage.html")
//        let vc = BaseWebViewController(url: URL(string: "http://127.0.0.1:8848/com_zxl_html/html/iosmessage.html")!, configuration: WKWebViewConfiguration())
        
        let vc = BaseWebViewController(urlString: "http://127.0.0.1:8848/com_zxl_html/html/iosmessage.html")
        self.navigationController?.pushViewController(vc)
    }

}
