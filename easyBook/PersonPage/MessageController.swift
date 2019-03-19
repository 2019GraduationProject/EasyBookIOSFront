//
//  MessageController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/1/23.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class MessageController: UITableViewController {
    
    var naviBarShadowImage = UIImage(named: "separator") // 存储导航条图片
    var initialOffsetY : CGFloat! // 初始位移量
    var isInitialCompute = true // 是否是第一次计算初始位移的标志
 
    var messageData: [Message] = [
        Message(title: "本科毕业设计", content: "事件地点从南京大学软件学院院楼710改为南京大学软件学院院楼712", time: "2019-02-25 14:56"),
        Message(title: "软件工程与计算II小组会", content: "事件开始时间从13:30改为14:30", time: "2019-02-28 10:15"),
        Message(title: "软件工程与计算II小组会", content: "事件地点从南大仙林图书馆220改为南大仙林图书馆221", time: "2019-02-28 12:15"),
        Message(title: "大数据时代讲座", content: "事件取消", time: "2019-03-25 15:00")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "我的消息"
        // 设置导航条标题字体颜色为黑色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        
        // 修改每个 section 之间的间距：修改 section 的 footer 的大小
        tableView.sectionFooterHeight = 8
        
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = String(describing: MessageSubtitleCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MessageSubtitleCell
     
        cell.titleLabel.text = messageData[indexPath.row].title
        cell.contentLabel.text = messageData[indexPath.row].content
        cell.timeLabel.text = messageData[indexPath.row].time
        
        return cell
    }
    
    /// 修改每个section之间的间距：修改section的header的大小
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消点击行则选中的状态
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    /// 每行右往左滑监听
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "删除") { (_, _, completion) in
            self.messageData.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            // 收起滑动侧边栏
            completion(true)
        }
        deleteAction.image = UIImage(named: "delete_24x24_")
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMessageDetail" {
            let messageDetailVC = segue.destination as! MessageDetailController
            let row = tableView.indexPathForSelectedRow!.row
            messageDetailVC.message = messageData[row]
        }
    }

}
