//
//  InvitationController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/23.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class InvitationController: UITableViewController {
    
    var naviBarShadowImage = UIImage(named: "separator") // 存储导航条图片
    var initialOffsetY : CGFloat! // 初始位移量
    var isInitialCompute = true // 是否是第一次计算初始位移的标志
    
    var inviterList = [
        Member(avatar: "avatar_boy_1_80x80_", name: "何老师", gender: "male", introducation: "NJU软件工程学院研究员", phone: "18023492265", personBg: "default_user_bg_375x320"),
        Member(avatar: "avatar_girl_1_80x80_", name: "成员4", gender: "female", introducation: "机器学习研究生", phone: "15151283345", personBg: "default_user_bg_375x320"),
    ]
    
    var invitationList = [
        Invitation(inviter: "何老师", inviterAvatar: "avatar_boy_1_80x80_", message: "何老师邀请你加入本科毕设iOS访谈app组"),
        Invitation(inviter: "同学1", inviterAvatar: "avatar_girl_1_80x80_", message: "同学1邀请你加入机器学习自习组")
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "新的邀请"
        // 设置导航条标题字体颜色为黑色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        
        // 设置返回按钮颜色
        navigationController?.navigationBar.tintColor = UIColor(named: "themeDarkBlack")
        
        // 去掉 tableview 多余的分割线
        self.tableView.tableFooterView = UIView.init()
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invitationList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = String(describing: GroupSubtitleCell.self)
        let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! GroupSubtitleCell
        
        cell.titleImageView.image = UIImage(named: invitationList[indexPath.row].inviterAvatar)
        cell.titleLabel.text = invitationList[indexPath.row].inviter
        cell.subTitleLabel.text = invitationList[indexPath.row].message

        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "删除") { (_, _, completion) in
            self.invitationList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            // 收起滑动侧边栏
            completion(true)
        }
        deleteAction.image = UIImage(named: "delete_24x24_")
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消点击行则选中的状态
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInvitationDetail" {
            let invitationDetailVC = segue.destination as! InvitationDetailController
            let row = tableView.indexPathForSelectedRow!.row
            invitationDetailVC.memberInfo = inviterList[row]
            invitationDetailVC.message = invitationList[row].message
        }
    }

}
