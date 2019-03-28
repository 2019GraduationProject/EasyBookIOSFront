//
//  ClauseCell.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/5.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class ClauseCell: UITableViewCell, UIScrollViewDelegate {
    
    @IBOutlet weak var timePeriodLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBOutlet weak var maxAmountTextField: UITextField!
    
    fileprivate lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var clauseStartTime: Date = Date() {
        didSet {
            self.startTimeLabel.text = self.timeFormatter.string(from: clauseStartTime)
        }
    }
    
    var clauseEndTime: Date = Date() {
        didSet {
            self.endTimeLabel.text = self.timeFormatter.string(from: clauseEndTime)
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let today = Date()
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: today)
        if dateComponents.minute! < 30 {
            clauseStartTime = self.timeFormatter.date(from: dateComponents.hour!.description + ":00")!
        } else {
            clauseStartTime = self.timeFormatter.date(from: dateComponents.hour!.description + ":30")!
        }
        clauseEndTime = clauseStartTime
        
        startTimePicker.addTarget(self, action: #selector(chooseStartTime( _:)), for: UIControl.Event.valueChanged)
        endTimePicker.addTarget(self, action: #selector(chooseEndTime( _:)), for: UIControl.Event.valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        maxAmountTextField.resignFirstResponder()
    }
    
    
    // MARK: - Event Listeners
    
    @objc func chooseStartTime(_ datePicker: UIDatePicker) {
        self.clauseStartTime = startTimePicker.date
    }

    @objc func chooseEndTime(_ datePicker: UIDatePicker) {
        self.clauseEndTime = endTimePicker.date
    }
    
}
