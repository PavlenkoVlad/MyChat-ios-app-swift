//
//  ReceiveTableViewCell.swift
//  MyChat
//
//  Created by Владислав Павленко on 27.10.2019.
//  Copyright © 2019 Владислав Павленко. All rights reserved.
//

import UIKit

class ReceiveTableViewCell: UITableViewCell {

    @IBOutlet weak var receiveMessageView: UIView!
    @IBOutlet weak var receiveMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        receiveMessageView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
