//
//  ChatTableViewController.swift
//  MyChat
//
//  Created by Владислав Павленко on 26.10.2019.
//  Copyright © 2019 Владислав Павленко. All rights reserved.
//

import UIKit
import SocketIO

class ChatTableViewController: UITableViewController {

    @IBOutlet weak var messageHistoryTableView: MessageHistoryTableView!
    
    @IBOutlet weak var sendMessageView: UIView!
    @IBOutlet weak var inputMessageTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    let socketIOClient = SocketIOController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageHistoryTableView.initialConfiguration()
        setConfigurationForSendButtonToRow()
        setConfigurationForInputMessageTextView()
        
        socketIOClient.setHandlerOnChatMessage(updateMessageHistoryTableView: messageHistoryTableView.addMessage(_:))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let safeAreaInsetBottom = self.view.safeAreaInsets.bottom + 20
        let messageHistoryRowHeight = self.view.frame.height - safeAreaInsetBottom - 44
        
        switch indexPath.row {
        case 0:
            return messageHistoryRowHeight
        default:
            return 44
        }
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        let message = Message(text: inputMessageTextView.text, typeOfMessage: .send)
        socketIOClient.send(message: message)
        messageHistoryTableView.addMessage(message)
        inputMessageTextView.text = nil
    }
    
    func setConfigurationForSendButtonToRow() {
        setSendButtonConstraints()
        sendButton.layer.cornerRadius = sendButton.frame.height / 2
    }
    
    func setSendButtonConstraints() {
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        let heightSendButtonConstraint = NSLayoutConstraint(item: sendButton!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 22)
        let widthSendButtonConstraint = NSLayoutConstraint(item: sendButton!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0)
        let verticalAlignmentSendButtonConstraint = NSLayoutConstraint(item: sendButton!, attribute: .centerY, relatedBy: .equal, toItem: sendMessageView!, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let trailingSendButtonConstraint = NSLayoutConstraint(item: sendButton!, attribute: .trailing, relatedBy: .equal, toItem: sendMessageView, attribute: .trailing, multiplier: 1.0, constant: -20.0)
        
        NSLayoutConstraint.activate([heightSendButtonConstraint, widthSendButtonConstraint, verticalAlignmentSendButtonConstraint, trailingSendButtonConstraint])
        sendMessageView.layoutIfNeeded()
    }
    
    func setConfigurationForInputMessageTextView() {
        setInputMessageConstraints()
        inputMessageTextView.layer.cornerRadius = inputMessageTextView.frame.height / 2
        inputMessageTextView.layer.borderWidth = 1
        inputMessageTextView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        inputMessageTextView.clipsToBounds = true
        inputMessageTextView.textContainerInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
    }
    
    func setInputMessageConstraints() {
        inputMessageTextView.translatesAutoresizingMaskIntoConstraints = false
        
        let topInputMessageTextViewConstraint = NSLayoutConstraint(item: inputMessageTextView!, attribute: .top, relatedBy: .equal, toItem: sendMessageView!, attribute: .top, multiplier: 1.0, constant: 10.0)
        let bottomInputMessageTextViewConstraint = NSLayoutConstraint(item: inputMessageTextView!, attribute: .bottom, relatedBy: .equal, toItem: sendMessageView!, attribute: .bottom, multiplier: 1.0, constant: -10.0)
        let leadingInputMessageTextViewConstraint = NSLayoutConstraint(item: inputMessageTextView!, attribute: .leading, relatedBy: .equal, toItem: sendMessageView!, attribute: .leading, multiplier: 1.0, constant: 20)
        let trailingInputMessageTextViewConstraint = NSLayoutConstraint(item: inputMessageTextView!, attribute: .trailing, relatedBy: .equal, toItem: sendButton!, attribute: .leading, multiplier: 1.0, constant: -10)
        
        NSLayoutConstraint.activate([topInputMessageTextViewConstraint, bottomInputMessageTextViewConstraint, leadingInputMessageTextViewConstraint, trailingInputMessageTextViewConstraint])
        sendMessageView.layoutIfNeeded()
    }
}
