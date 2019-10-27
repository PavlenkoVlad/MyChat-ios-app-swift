//
//  SendMessageTableViewCell.swift
//  MyChat
//
//  Created by Владислав Павленко on 26.10.2019.
//  Copyright © 2019 Владислав Павленко. All rights reserved.
//

import UIKit

class SendMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var sendMessageView: UIView!
    @IBOutlet weak var sendMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sendMessageView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
