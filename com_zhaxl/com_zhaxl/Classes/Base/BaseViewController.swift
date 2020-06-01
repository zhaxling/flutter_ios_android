//
//  BaseViewController.swift
//  com_music
//
//  Created by ZXL on 2020/5/26.
//  Copyright © 2020 zxl. All rights reserved.
//

import UIKit
import WebKit

class BaseViewController: UIViewController {
    
//    let webView = WKWebView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        webView.frame = view.bounds
//        view.addSubview(webView)

        view.backgroundColor = UIColor.randomColor
        
    }
    

}


extension UIColor {
    //返回随机颜色
    class var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
