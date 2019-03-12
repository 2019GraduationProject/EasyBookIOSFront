//
//  SetGenderController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/12.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class SetGenderController: UITableViewController {
    
    @IBOutlet weak var maleTickImageView: UIImageView!
    @IBOutlet weak var femaleTickImageView: UIImageView!

    var gender: String = "male"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // 去掉 tableview 多余的分割线
        self.tableView.tableFooterView = UIView.init()
        
        maleTickImageView.isHidden = (gender == "male" ? false : true)
        femaleTickImageView.isHidden = (gender == "female" ? false : true)
    }
    
    
    // MARK: - Table View
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消点击行则选中的状态
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            gender = "male"
            maleTickImageView.isHidden = false
            femaleTickImageView.isHidden = true
        } else {
            gender = "female"
            maleTickImageView.isHidden = true
            femaleTickImageView.isHidden = false
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    
    // MARK: - Event Listeners
    
    @IBAction func tapCancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapSaveButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}
