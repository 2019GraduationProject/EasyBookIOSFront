//
//  MyGroupDetailController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/22.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class MyGroupDetailController: UITableViewController {
    
    @IBOutlet weak var groupNameLabel: UILabel!
    var groupName: String!
    
    let memberList: [Member] = [
        Member(avatar: "default_avater_80x80_", name: "黄小白", gender: "female", introducation: "iOS开发工程师", phone: "13912575745", personBg: "default_user_bg_375x320", isHolder: true),
        Member(avatar: "avatar_boy_1_80x80_", name: "成员2", gender: "male", introducation: "后端工程师", phone: "13912345678", personBg: "default_user_bg_375x320"),
        Member(avatar: "avatar_boy_2_80x80_", name: "成员3", gender: "male", introducation: "架构师", phone: "18015886463", personBg: "default_user_bg_375x320"),
        Member(avatar: "avatar_girl_1_80x80_", name: "成员4", gender: "female", introducation: "前端工程师", phone: "15151283345", personBg: "default_user_bg_375x320"),
        Member(avatar: "avatar_girl_2_80x80_", name: "成员5", gender: "female", introducation: "UI设计师", phone: "13754432290", personBg: "default_user_bg_375x320"),
        Member(avatar: "avatar_boy_3_80x80_", name: "成员6", gender: "male", introducation: "机器学习研究生", phone: "15823294579", personBg: "default_user_bg_375x320"),
    ]
    

    var naviBarShadowImage = UIImage(named: "separator") // 存储导航条图片
    var initialOffsetY : CGFloat! // 初始位移量
    var isInitialCompute = true // 是否是第一次计算初始位移的标志
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "群组信息"
        // 设置导航条标题字体颜色为黑色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        // 设置返回按钮颜色
        navigationController?.navigationBar.tintColor = UIColor(named: "themeDarkBlack")
        
        tableView.sectionFooterHeight = 0
        
        // 创建重用的单元格
        self.tableView.register(UINib(nibName: "GroupMemberCell", bundle: nil), forCellReuseIdentifier: "GroupMemberCell")
        
        self.groupNameLabel.text = groupName
    }
    
    /// 去掉子页面返回按钮后的文字
    ///
    /// - Parameter animated:
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 设置返回按钮后的文字
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return memberList.count
        } else {
            return super.tableView(self.tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let reuseIdentifier = String(describing: GroupMemberCell.self)
            let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! GroupMemberCell
            
            cell.avatarImageView.image = UIImage(named: memberList[indexPath.row].avatar)
            cell.memberNameLabel.text = memberList[indexPath.row].name
            if memberList[indexPath.row].isHolder {
                cell.groupHolderLabel.isHidden = false
            } else {
                cell.groupHolderLabel.isHidden = true
            }
            
            return cell
        }
        else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    /// 因为动态添加分区单元格，会引起cell高度的变化，所以要重新设置
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 56
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    /// 当覆盖了静态的 cell 数据源方法时需要提供一个代理方法,
    /// 因为数据源对新加进来的 cell 一无所知，所以要使用这个代理方法
    override func tableView(_ tableView: UITableView,
                            indentationLevelForRowAt indexPath: IndexPath) -> Int {
        if indexPath.section == 1 {
            let newIndexPath = IndexPath(row: 0, section: indexPath.section)
            return super.tableView(tableView, indentationLevelForRowAt: newIndexPath)
        } else {
            return super.tableView(tableView, indentationLevelForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消点击行则选中的状态
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            if let memberDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MemberDetailController") as? MemberDetailController {
                let memberInfo = memberList[indexPath.row]
                memberDetailVC.memberInfo = memberInfo
                memberDetailVC.showBtn = !memberInfo.isHolder
                self.navigationController?.pushViewController(memberDetailVC, animated: true)
            }
        }
        else if indexPath.section == 3 {
            let actionSheet = UIAlertController(title: nil, message: "确认解散该群？", preferredStyle: .actionSheet)
            
            let confirmAction = UIAlertAction(title: "确认解散", style: .default) { (_) in
                // TODO
            }
            confirmAction.setValue(UIColor.darkText, forKey: "titleTextColor")
            
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            cancelAction.setValue(UIColor(named: "themeColor"), forKey: "titleTextColor")
            
            actionSheet.addAction(confirmAction)
            actionSheet.addAction(cancelAction)
            
            present(actionSheet, animated: true, completion: nil)
        }
    }
    
    /// 修改每个section之间的间距：修改section的header的大小
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 || section == 3 {
            return 15
        } else {
            return 30
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
