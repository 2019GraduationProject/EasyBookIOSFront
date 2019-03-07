//
//  LoginController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/2/22.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置导航条背景透明
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // 输入内容会显示成小黑点
        passwordTextField.isSecureTextEntry = true
    }
    
    // 设置状态栏字体颜色为白色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// 去掉子页面返回按钮后的文字
    ///
    /// - Parameter animated:
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 设置返回按钮后的文字
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
    // MARK: - Event Listeners
    
    /// 登录方法
    ///
    /// - Parameter sender: 登录按钮
    @IBAction func tapLogin(_ sender: UIButton) {
        // TODO 登录逻辑写这里！
        performSegue(withIdentifier: "login", sender: self)
        UserDefaults.standard.set(true, forKey: "ifLogin")
    }
    
    
    /// 点击空白处收回键盘
    ///
    /// - Parameter sender: UITapGestureRecognizer
    @IBAction func tapBlank(_ sender: UITapGestureRecognizer) {
        if accountTextField.isFirstResponder {
            accountTextField.resignFirstResponder()
        }
        else if passwordTextField.isFirstResponder {
            passwordTextField.resignFirstResponder()
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
