//
//  AppDelegate.swift
//  com_zhaxl
//
//  Created by ZXL on 2020/5/30.
//  Copyright © 2020 zxl. All rights reserved.
//

import UIKit
import Flutter
import FlutterPluginRegistrant

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
//class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var flutterEngine = FlutterEngine(name: "com.ios.flutter.engine")
//    var window: UIWindow?
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        window?.backgroundColor = UIColor.white
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
        
        flutterRun()
        
        return true
    }
}

extension AppDelegate {
    func flutterRun() {
        flutterEngine.run()
        GeneratedPluginRegistrant.register(with: self.flutterEngine)
    }
}
