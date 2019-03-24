//
//  SetNameController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/12.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class SetNameController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    var name: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 去掉 tableview 多余的分割线
        self.tableView.tableFooterView = UIView.init()
        nameTextField.text = name
        nameTextField.becomeFirstResponder()
        nameTextField.enablesReturnKeyAutomatically = true
        nameTextField.delegate = self
    }
    
    /// 退出本界面时收回键盘
    ///
    /// - Parameter animated: Bool
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        nameTextField.resignFirstResponder()
    }
    
    
    // MARK: - Table View
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    

    // MARK: - Event Listeners

    @IBAction func tapCancelButton(_ sender: UIBarButtonItem) {
//        nameTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapSaveButton(_ sender: UIBarButtonItem) {
//        nameTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
}
