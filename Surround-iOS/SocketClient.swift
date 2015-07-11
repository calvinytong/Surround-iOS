//
//  SocketClient.swift
//  Surround-iOS
//
//  Created by Calvin on 7/10/15.
//  Copyright (c) 2015 Calvin. All rights reserved.
//

import Foundation
import Socket_IO_Client_Swift

class SocketClient
{
    var socket : SocketIOClient = SocketIOClient(socketURL: "172.16.51.130:5000")
    var url : String!
    
    init()
    {
    }
    
    func connect(completionHandler: (Bool!, NSError!) -> Void)
    {
        socket.on("connect") {data, ack in
            println("socket connected")
            self.socket.emit("rtsp url", "")
        }
        
        socket.on("rtsp url response") {data, ack in
            println("Message for you! \(data?[0])")
            self.url = data?[0] as! String
            println(self.url)
            completionHandler(true, nil)
        }
        
        socket.connect()
    }
}