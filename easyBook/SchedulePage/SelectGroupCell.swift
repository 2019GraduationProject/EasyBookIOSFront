//
//  SelectGroupCell.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/8.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class SelectGroupCell: UITableViewCell {
    
    @IBOutlet weak var checkBox: BEMCheckBox!
    @IBOutlet weak var groupNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkBox.onAnimationType = .bounce
        checkBox.offAnimationType = .bounce
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
