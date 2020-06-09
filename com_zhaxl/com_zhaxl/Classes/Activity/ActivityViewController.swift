//
//  ActivityViewController.swift
//  com_zhaxl
//
//  Created by ZXL on 2020/5/31.
//  Copyright © 2020 zxl. All rights reserved.
//

import UIKit
import Flutter

class ActivityViewController: BaseViewController {
    
    var uri = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        let titles = ["Flutter 测试1","Flutter 测试2","Flutter 测试3"]
        
        var Y = 150
        var tag = 10
        
        
        for str in titles {
            let btn = UIButton(frame: CGRect(x: 10, y: Y, width: Int(UIScreen.main.bounds.size.width) - 20, height: 38))
            btn.setTitle(str, for: .normal)
            btn.backgroundColor = UIColor.orange
            btn.tag = tag
            btn.addTarget(self, action: #selector(tapClick), for: .touchUpInside)
            view.addSubview(btn)
            Y = Y + 38 + 10
            tag = tag + 10
        }
    }
    
    @objc func tapClick(btn:UIButton) {
        
        print(btn.tag)
        
        if btn.tag == 10 {

            let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
            let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
            flutterViewController.modalPresentationStyle = .fullScreen
            flutterViewController.title = "记账"
            self.navigationController?.present(flutterViewController, animated: true, completion: nil)
            //            self.navigationController?.pushViewController(flutterViewController)
            
            let channel = FlutterMethodChannel(name: "com.pages/native_ios", binaryMessenger: flutterViewController as! FlutterBinaryMessenger)
            channel.setMethodCallHandler { (call, result) in
                print("method = ", call.method, "arguments = ", call.arguments ?? "argumentsNULL", result)

                // 方法
                let method = call.method

                if method == "flutterPop" {
                    flutterViewController.dismiss(animated: true, completion: nil)
//                    self.navigationController?.popViewController()
                }

            }
        }
        
        if btn.tag == 20 {
            let flutterViewController = FlutterViewController(project: nil, nibName: nil, bundle: nil)

            flutterViewController.setInitialRoute("MyApp")

            let channel = FlutterMethodChannel(name: "com.flutter.channel.ios", binaryMessenger: flutterViewController as! FlutterBinaryMessenger)
            channel.setMethodCallHandler { (call, result) in
                print("method = ", call.method, "arguments = ", call.arguments ?? "argumentsNULL", result)

                // 方法
                let method = call.method

                if method == "pop" {
                    self.navigationController?.popViewController()
                }
                else if method == "push" {
                    let uri = (call.arguments as! Dictionary<String, Any>)["uri"]
                    let vc = ActivityViewController()
                    vc.uri = uri as! String
                    self.navigationController?.pushViewController(vc)
                }
                else if method == "payResult" {
                    let dic = ["a":"传给Flutter参数"]
                    result(dic)
                }

            }
            self.navigationController?.pushViewController(flutterViewController, animated: true)
        }
    }
    

    
}
