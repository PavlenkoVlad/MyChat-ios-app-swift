//
//  File.swift
//  MyChat
//
//  Created by Владислав Павленко on 27.10.2019.
//  Copyright © 2019 Владислав Павленко. All rights reserved.
//

import SocketIO

class SocketIOController {
    let urlString = "wss://hidden-fjord-32367.herokuapp.com"
    var socketIOManager: SocketManager
    var socketIOClient: SocketIOClient
    
    init() {
        socketIOManager = SocketManager(socketURL: URL(string: urlString)!)
        socketIOClient = socketIOManager.defaultSocket
    }
    
    func connect() {
        socketIOClient.connect()
    }
    
    func disconnect() {
        socketIOManager.disconnect()
    }
    
    func setHandlerOnChatMessage(updateMessageHistoryTableView: @escaping (Message) -> Void) {
        socketIOClient.on("chatMessage") { (data, ack) in
            let textOfMessage = data[0] as! String
            let message = Message(text: textOfMessage, typeOfMessage: .receive)
            updateMessageHistoryTableView(message)
        }
    }
    
    func send(message: Message) {
        let textOfMessage = message.text
        socketIOClient.emit("chatMessage", with: [textOfMessage])
    }
}
