//
//  NewGroupController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/24.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit
import FTIndicator

class NewGroupController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var countLabel: UILabel!
    
    var count: Int! {
        didSet {
            self.countLabel.text = (12 - count).description
        }
    }
    
    var naviBarShadowImage = UIImage(named: "separator") // 存储导航条图片
    var initialOffsetY : CGFloat! // 初始位移量
    var isInitialCompute = true // 是否是第一次计算初始位移的标志
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FTIndicator.setIndicatorStyle(.dark)
        
        self.navigationItem.title = "新建群组"
        // 设置导航条标题字体颜色为黑色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        // 设置返回按钮颜色
        navigationController?.navigationBar.tintColor = UIColor(named: "themeDarkBlack")
        
        let barButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(newGroup))
        barButtonItem.tintColor = UIColor(named: "themeColor")
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        groupNameTextField.enablesReturnKeyAutomatically = true
        groupNameTextField.becomeFirstResponder()
        groupNameTextField.delegate = self
        
        count = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        groupNameTextField.becomeFirstResponder()
        // 取消 section 的点击效果
        tableView.cellForRow(at: [0, 0])?.selectionStyle = .none
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        groupNameTextField.resignFirstResponder()
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
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        groupNameTextField.resignFirstResponder()
        return true
    }
    
    /// 设置手动输入字数不超12位
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = groupNameTextField.text else {
            return true
        }
        
        let newLength = text.count + string.count - range.length
        if newLength <= 12 {
            count = newLength
        }
        
        return newLength <= 12
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    // MARK: - Event Listeners
    
    /// 新建群组监听
    /// 新建的群组默认群成员为自己，是群主，显示在“我创建的群组”里
    @objc func newGroup() {
        if groupNameTextField.text == "" {
            FTIndicator.showInfo(withMessage: "请输入群组名称")
        } else {
            FTIndicator.showSuccess(withMessage: "新建群组完成")
            // TODO
            self.navigationController?.popViewController(animated: true)
        }
    }

}
