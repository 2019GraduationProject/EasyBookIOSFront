//
//  DetailClauseCell.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/11.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit
import FTIndicator

class DetailClauseCell: UITableViewCell {
    
    @IBOutlet weak var timePeriodLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var bookBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        FTIndicator.setIndicatorStyle(.dark)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapBookBtn(_ sender: UIButton) {
        if bookBtn.titleLabel?.text == "预约" {
            FTIndicator.showSuccess(withMessage: "预约成功")
            bookBtn.backgroundColor = UIColor.lightGray
            bookBtn.setTitle("取消", for: .normal)
        }
        else {
            FTIndicator.showSuccess(withMessage: "已取消预约")
            bookBtn.backgroundColor = UIColor(named: "themeColor")
            bookBtn.setTitle("预约", for: .normal)
        }
    }
    
}
