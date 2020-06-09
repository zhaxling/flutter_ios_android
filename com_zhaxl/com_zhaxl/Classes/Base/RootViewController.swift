//
//  RootViewController.swift
//  com_music
//
//  Created by ZXL on 2020/5/26.
//  Copyright © 2020 zxl. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fourVC = MeViewController()
        fourVC.title = "我的"
        self.addChild(BaseNavigationController(rootViewController: fourVC))
        
        let firstVC = HomeViewController()
        firstVC.title = "首页"
        self.addChild(BaseNavigationController(rootViewController: firstVC))
        
        
        let secondVC = BaseViewController()
        secondVC.title = "消息"
        self.addChild(BaseNavigationController(rootViewController: secondVC))
        
        
        let thirdVC = ActivityViewController()
        thirdVC.title = "活动"
        self.addChild(BaseNavigationController(rootViewController: thirdVC))
        
    }
    
    
}
