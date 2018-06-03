//
//  MessageCell.swift
//  Fast Chat
//
//  Created by Rosemberg Torres Nunes on 03/06/2018.
//  Copyright © 2018 Rosemberg Torres Nunes. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var labelTextMesg: UILabel!
    @IBOutlet weak var viewMessage: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
