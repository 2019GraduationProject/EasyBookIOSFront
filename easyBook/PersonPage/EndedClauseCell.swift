//
//  EndedClauseCell.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/18.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class EndedClauseCell: UITableViewCell {
    
    @IBOutlet weak var timePeriodLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
