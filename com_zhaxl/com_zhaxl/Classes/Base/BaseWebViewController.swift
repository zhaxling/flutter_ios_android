//
//  BaseWebViewController.swift
//  com_zhaxl
//
//  Created by ZXL on 2020/7/1.
//  Copyright © 2020 zxl. All rights reserved.
//

import UIKit
import AXWebViewController

class BaseWebViewController: AXWebViewController {
    
    var config: WKWebViewConfiguration? = nil
    
    /**
         调用相关
             指定构造器必须调用它直接父类的指定构造器方法.
             便利构造器必须调用同一个类中定义的其它初始化方法.
             便利构造器在最后必须调用一个指定构造器.
         属性相关
             指定构造器必须要确保所有被类中提到的属性在代理向上调用父类的指定构造器前被初始化, 之后才能将其它构造任务代理给父类中的构造器.
             指定构造器必须先向上代理调用父类中的构造器, 然后才能为任意属性赋值.
             便利构造器必须先代理调用同一个类中的其他构造器, 然后再为属性赋值.
             构造器在第一阶段构造完成之前, 不能调用任何实例方法, 不能读取任何实例属性的值，self 不能被引用.
         继承相关
             如果子类没有定义任何的指定构造器, 那么会默认继承所有来自父类的指定构造器.
             如果子类提供了所有父类指定构造器的实现, 不管是通过上一条规则继承过来的, 还是通过自定义实现的, 它将自动继承所有父类的便利构造器.
     */
    convenience init(urlString: String) {

        if let URI = URL(string: urlString) {

            let config = WKWebViewConfiguration()
            let userController = WKUserContentController()
            config.userContentController = userController
            config.preferences = WKPreferences()
            config.selectionGranularity = .dynamic
            
            self.init(url: URI, configuration: config)
            
            // 便利构造器调用self必须在指定构造器之后
            self.config = config
        }
        else {
            self.init(url: URL(string: "https://baidu.com")!)
        }
        
    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.random
        self.navigationController?.navigationBar.barTintColor = UIColor.random
        
        self.showsToolBar = false
        self.navigationType = .barItem
        self.enabledWebViewUIDelegate = true
        self.showsNavigationBackBarButtonItemTitle = false
        // 支持两个左边按钮
        self.navigationItem.leftItemsSupplementBackButton = false
        self.webView.scrollView.bounces = false
        
        
        // 添加方法
        self.config?.userContentController .add(self, name: "getUserInfo")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.config?.userContentController.removeScriptMessageHandler(forName: "getUserInfo")
    }
}

extension BaseWebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        print(message.name)
        
        if let dic:Dictionary = message.body as? Dictionary<String, Any> {
            print("参数：\(String(describing: dic["id"]))")
        }
        
        if message.name == "getUserInfo" {

            let js = "returnUserId('sfjlsflj')"
            
            
            webView.evaluateJavaScript(js) { (data, error) in
                if ((error) != nil) {
                    print("出错：\(error.debugDescription)")
                }
            }
        }
    }
    
    
}

