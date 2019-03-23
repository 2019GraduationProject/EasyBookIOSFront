//
//  InviteMemberController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/23.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class InviteMemberController: UITableViewController, UITextFieldDelegate {
    
    var naviBarShadowImage = UIImage(named: "separator") // 存储导航条图片
    var initialOffsetY : CGFloat! // 初始位移量
    var isInitialCompute = true // 是否是第一次计算初始位移的标志
    
    @IBOutlet weak var memberTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "邀请新成员"
        // 设置导航条标题字体颜色为黑色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        // 设置返回按钮颜色
        navigationController?.navigationBar.tintColor = UIColor(named: "themeDarkBlack")
        
        memberTextField.becomeFirstResponder()
        memberTextField.enablesReturnKeyAutomatically = true
        memberTextField.delegate = self
    }
    
    /// 去掉子页面返回按钮后的文字
    ///
    /// - Parameter animated:
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 设置返回按钮后的文字
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        memberTextField.resignFirstResponder()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        memberTextField.becomeFirstResponder()
        // 取消 section 的点击效果
        tableView.cellForRow(at: [0, 0])?.selectionStyle = .none
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
        return 0.1
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let memberDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MemberDetailController") as? MemberDetailController {
            let memberInfo = Member(avatar: "avatar_girl_2_80x80_", name: "成员5", gender: "female", introducation: "UI设计师", phone: "13754432290", personBg: "default_user_bg_375x320")
            memberDetailVC.memberInfo = memberInfo
            memberDetailVC.btnType = "add"
            memberDetailVC.showBtn = true
            self.navigationController?.pushViewController(memberDetailVC, animated: true)
        }
        return true
    }
    
    /// 设置手动输入位数不超11位
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = memberTextField.text else {
            return true
        }
        
        let newLength = text.count + string.count - range.length
        return newLength <= 11
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
