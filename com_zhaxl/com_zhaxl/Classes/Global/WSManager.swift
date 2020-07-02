//
//  WSManager.swift
//  com_zhaxl
//
//  Created by ZXL on 2020/7/1.
//  Copyright © 2020 zxl. All rights reserved.
//

import UIKit
import Starscream

class WSManager: NSObject {
    
    static let manager: WSManager = WSManager()
    
    var socket: WebSocket? = nil
    
    var connected = false
    
    
    func connect() {
        
        guard let url = URL(string: "ws://127.0.0.1:8010")
            else { return }
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        request.setValue("1", forHTTPHeaderField: "client")
        request.setValue("echo-protocol", forHTTPHeaderField: "Sec-WebSocket-Protocol")
        
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()
    }
    
    func sendData() {
        // socket?.write(data: <#T##Data#>, completion: <#T##(() -> ())?##(() -> ())?##() -> ()#>)
        
        socket?.write(string: "123", completion: {
            
        })
    }
    
    func disconect() {
        if connected {
            socket?.disconnect()
            socket = nil
        }
    }
}

extension WSManager: WebSocketDelegate {
    
    // Receiving data from a WebSocket
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            connected = true
            print("连接成功")
            break
            
        case .disconnected(let reason, let code):
            connected = false
            print("断开连接")
            break
            
        case .text(let text):
            print("收到：\(text)")
            break
            
        case .binary(let data):
            print("收到数据：\(data)")
            break
            
        case .ping(_):
            print("-ping- \(Date())")
            break
            
        case .pong(_):
            print("-pong- \(Date())")
            break
            
        case .viabilityChanged(_):
            break
            
        case .reconnectSuggested(_):
            break
            
        case.cancelled:
            connected = false
            
        case .error(let error):
            connected = false
            print(error as Any)
            break
        }
    }
    
    
}
