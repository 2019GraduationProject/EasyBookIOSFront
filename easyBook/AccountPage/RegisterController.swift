//
//  RegisterController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/2/23.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var verificationCodeTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置导航条背景透明
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // 输入内容会显示成小黑点
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
    }
    
    
    // MARK: - Event Listeners
    
    /// 点击空白处收回键盘
    ///
    /// - Parameter sender: UITapGestureRecognizer
    @IBAction func tapBlank(_ sender: UITapGestureRecognizer) {
        phoneTextField.resignFirstResponder()
        verificationCodeTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
