//
//  MessageHistoryTableView.swift
//  MyChat
//
//  Created by Владислав Павленко on 26.10.2019.
//  Copyright © 2019 Владислав Павленко. All rights reserved.
//

import UIKit

class MessageHistoryTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    var messages: [Message] = []
    
    func initialConfiguration() {
        dataSource = self
        delegate = self
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 44.0
        translatesAutoresizingMaskIntoConstraints = false
        register(UINib(nibName: "SendMessageTableViewCell", bundle: nil), forCellReuseIdentifier: "SendMessageCell")
        register(UINib(nibName: "ReceiveTableViewCell", bundle: nil), forCellReuseIdentifier: "ReceiveMessageCell")
        setObserverForKeyboardNotifications()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        switch message.type {
        case .send:
            return setSendMessageContent(tableView, cellForRowAt: indexPath, messageText: message.text)
        case .receive:
            return setReceiveMessageContent(tableView, cellForRowAt: indexPath, messageText: message.text)
        }
    }
    
    func setSendMessageContent(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, messageText text: String) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SendMessageCell", for: indexPath) as! SendMessageTableViewCell
        cell.sendMessageLabel.text = text
        return cell
    }
    
    func setReceiveMessageContent(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, messageText text: String) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiveMessageCell", for: indexPath) as! ReceiveTableViewCell
        cell.receiveMessageLabel.text = text
        return cell
    }
    
    func addMessage(_ message: Message) {
        let indexPath = IndexPath(row: messages.count, section: 0)
        messages.append(message)
        beginUpdates()
        insertRows(at: [indexPath], with: .automatic)
        endUpdates()
    }
    
    func setObserverForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(registerForKeyboardDidShowNotification(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(registerForKeyboardWillHideNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func registerForKeyboardDidShowNotification(_ notification: Notification) {
        guard let info = notification.userInfo, let keyboardFrameValue = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardValue = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardValue.size
        let contentInsets = UIEdgeInsets(top: keyboardSize.height, left: 0, bottom: 0, right: 0)
        UIView.animate(withDuration: 0.5) {
            self.contentInset = contentInsets
        }
    }
    
    @objc func registerForKeyboardWillHideNotification(_ notification: Notification) {
        UIView.animate(withDuration: 0.5) {
            self.contentInset = .zero
        }
    }
}
