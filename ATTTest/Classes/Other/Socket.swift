//
//  Socket.swift
//  翠堤湾
//
//  Created by 凌甜 on 2021/5/6.
//

import UIKit

public class Socket: NSObject {
    public lazy var udpSocket : GCDAsyncUdpSocket = {
        let udpSocket = GCDAsyncUdpSocket.init(delegate: self, delegateQueue: dispatch_queue_global_t.global())
        do {
            try udpSocket.bind(toPort: 8989)
            try udpSocket.enableBroadcast(true)
        }
        catch let error {
            print(error)
        }
        return udpSocket
    }()
    public  static let sharedInstance: Socket = {
       let socket = Socket()
        
        return socket
    }()
}

extension Socket : GCDAsyncUdpSocketDelegate {
   public func broadCast(message: String) {
        guard let mesData = message.data(using: .utf8)  else {
            return
        }
        udpSocket.send(mesData, toHost: "192.158.1.159", port:8989, withTimeout: 10, tag: 100)
        print(message)
    }
}
