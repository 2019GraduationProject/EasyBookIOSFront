//
//  SendMessageController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/23.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit
import FTIndicator

class SendMessageController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var messageTextField: UITextField!
    
    var naviBarShadowImage = UIImage(named: "separator") // 存储导航条图片
    var initialOffsetY : CGFloat! // 初始位移量
    var isInitialCompute = true // 是否是第一次计算初始位移的标志

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "群成员验证"
        // 设置导航条标题字体颜色为黑色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        // 设置返回按钮颜色
        navigationController?.navigationBar.tintColor = UIColor(named: "themeDarkBlack")
        
        let barButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(sendMessage))
        barButtonItem.tintColor = UIColor(named: "themeColor")
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        messageTextField.enablesReturnKeyAutomatically = true
        messageTextField.becomeFirstResponder()
        messageTextField.delegate = self
        
        FTIndicator.setIndicatorStyle(.dark)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        messageTextField.becomeFirstResponder()
        // 取消 section 的点击效果
        tableView.cellForRow(at: [0, 0])?.selectionStyle = .none
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        messageTextField.resignFirstResponder()
    }

    
    /// 屏幕从初始位置往下滚动，显示 tab bar，否则设置 tab bar 透明
    ///
    /// - Parameter scrollView: tableView 本身的 scrollView
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isInitialCompute {
            initialOffsetY = scrollView.contentOffset.y
            isInitialCompute = false
        }
        
        if scrollView.contentOffset.y > initialOffsetY {
            navigationController?.navigationBar.shadowImage = naviBarShadowImage
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        } else {
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        messageTextField.resignFirstResponder()
        return true
    }

    
    // MARK: - Event Listeners
    
    /// 发送验证消息
    @objc func sendMessage() {
        // TODO
        FTIndicator.showSuccess(withMessage: "验证消息已发送")
        self.navigationController?.popViewController(animated: true)
    }
    
}
