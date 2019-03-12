//
//  ResetPasswordController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/2/24.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class ResetPasswordController: UIViewController {
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var verificationCodeTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置导航条背景透明
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // 输入内容会显示成小黑点
        newPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
    }
    
    /// 退出本界面时收回键盘
    ///
    /// - Parameter animated: Bool
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if phoneTextField.isFirstResponder {
            phoneTextField.resignFirstResponder()
        }
        else if verificationCodeTextField.isFirstResponder {
            verificationCodeTextField.resignFirstResponder()
        }
        else if newPasswordTextField.isFirstResponder {
            newPasswordTextField.resignFirstResponder()
        }
        else if confirmPasswordTextField.isFirstResponder {
            confirmPasswordTextField.resignFirstResponder()
        }
    }
    
    
    // MARK: - Event Listeners
    
    /// 点击空白处收回键盘
    ///
    /// - Parameter sender: UITapGestureRecognizer
    @IBAction func tapBlank(_ sender: UITapGestureRecognizer) {
        if phoneTextField.isFirstResponder {
            phoneTextField.resignFirstResponder()
        }
        else if verificationCodeTextField.isFirstResponder {
            verificationCodeTextField.resignFirstResponder()
        }
        else if newPasswordTextField.isFirstResponder {
            newPasswordTextField.resignFirstResponder()
        }
        else if confirmPasswordTextField.isFirstResponder {
            confirmPasswordTextField.resignFirstResponder()
        }
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
