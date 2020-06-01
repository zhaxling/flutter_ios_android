//
//  BaseNavigationController.swift
//  com_music
//
//  Created by ZXL on 2020/5/26.
//  Copyright © 2020 zxl. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = self.viewControllers.count >= 1
        super.pushViewController(viewController, animated: animated)
    }
}
