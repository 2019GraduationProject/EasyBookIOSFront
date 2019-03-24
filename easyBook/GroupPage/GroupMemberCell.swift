//
//  GroupMemberCell.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/22.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class GroupMemberCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: CustomImageView!
    @IBOutlet weak var memberNameLabel: UILabel!
    @IBOutlet weak var identityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
