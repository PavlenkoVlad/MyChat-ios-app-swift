//
//  Message.swift
//  MyChat
//
//  Created by Владислав Павленко on 27.10.2019.
//  Copyright © 2019 Владислав Павленко. All rights reserved.
//

enum MessageType {
    case send
    case receive
}

class Message {
    var text: String
    var type: MessageType
    
    init(text: String, typeOfMessage type: MessageType) {
        self.text = text
        self.type = type
    }
}
