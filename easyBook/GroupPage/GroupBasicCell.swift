//
//  GroupBasicCell.swift
//  easyBook
//
//  Created by 黄小白 on 2019/1/22.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class GroupBasicCell: UITableViewCell {
    
    @IBOutlet weak var titleImageView: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
