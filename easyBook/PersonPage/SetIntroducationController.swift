//
//  SetIntroducationController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/16.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class SetIntroducationController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var introTextField: UITextField!
    var briefIntro: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 去掉 tableview 多余的分割线
        self.tableView.tableFooterView = UIView.init()
        introTextField.text = briefIntro
        introTextField.becomeFirstResponder()
        introTextField.enablesReturnKeyAutomatically = true
        introTextField.delegate = self
    }
    
    /// 退出本界面时收回键盘
    ///
    /// - Parameter animated: Bool
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        introTextField.resignFirstResponder()
    }
    
    
    // MARK: - Table View
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        introTextField.resignFirstResponder()
        return true
    }
    
    
    // MARK: - Event Listeners
    
    @IBAction func tapCancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapSaveButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
