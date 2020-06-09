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

class MeViewController: BaseViewController {
    
    let ScreenWidth = UIScreen.main.bounds.size.width
    let ScreenHeight = UIScreen.main.bounds.size.height
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton()
        btn.frame = CGRect(x: ScreenWidth * 0.25, y: ScreenHeight * 0.6, width: ScreenWidth * 0.5, height: ScreenWidth * 0.5)
        btn.setTitle("记账", for: .normal)
        btn.backgroundColor = UIColor.orange
        btn.addTarget(self, action: #selector(tapClick), for: .touchUpInside)
        btn.layer.cornerRadius = ScreenWidth * 0.25
        view.addSubview(btn)
    }
    
    @objc func tapClick(btn :UIButton) {
        
        self.choose()
        
        let url = "http://192.168.1.109:8090/accounter/calculation?startDate=2020-05-20&endDate=2020-06-20"
        

//        AF.request(url, method: .get).responseJSON { (json) in
//
//            self.requestSuccess(data: json)
//        }
    }

}

extension MeViewController {
    func requestSuccess(data: AFDataResponse<Any>) {
        
        if let json:Array = data.value as? Array<Any> {
    
            var msg = ""
            for person in json {
                let jsonPerson = JSON(person);
                msg.append("\(jsonPerson["name"] )    :  \(jsonPerson["money"])\n")
            }
            
            let title = "结算成功"
            
            let alert = UIAlertController(title: title, message: msg, defaultActionButtonTitle: "确定", tintColor: .orange)
            
            
            let attMsg = NSMutableAttributedString(string: msg)
            attMsg.addAttributes([.font:UIFont.systemFont(ofSize: 18)], range: NSRange(location: 0, length: msg.count))
            alert.setValue(attMsg, forKey: "attributedMessage")
            
            let attTitle = NSMutableAttributedString(string: title)
            attTitle.addAttributes([.font:UIFont.systemFont(ofSize: 18),.foregroundColor:UIColor.orange], range: NSRange(location: 0, length: title.count))
            alert.setValue(attTitle, forKey: "attributedTitle")


            self .present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "请求失败", message: "请求失败", defaultActionButtonTitle: "确定", tintColor: .orange)
            
            self .present(alert, animated: true, completion: nil)
        }
    }
    
}


extension MeViewController {
    func choose() {

        let alert = UIAlertController(title: "请选择记账人", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "球", style: .default, handler: { (action) in
            self.next(index: 1)
        }))
        alert.addAction(UIAlertAction(title: "风", style: .default, handler: { (action) in
                   self.next(index: 2)
               }))
        alert.addAction(UIAlertAction(title: "胖", style: .default, handler: { (action) in
                   self.next(index: 3)
               }))
        alert.addAction(UIAlertAction(title: "查查", style: .default, handler: { (action) in
                   self.next(index: 4)
               }))
        alert.addAction(UIAlertAction(title: "取消", style: .default, handler: { (action) in
                   
               }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func next(index: Int) {
        let vc = InputViewController()
        vc.index = index
        self.navigationController?.pushViewController(vc)
    }
}
