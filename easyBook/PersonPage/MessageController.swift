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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "我的消息"
        // 设置导航条标题字体颜色为黑色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        // 去掉 tableview 多余的分割线
        self.tableView.tableFooterView = UIView.init()
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
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = String(describing: MessageSubtitleCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MessageSubtitleCell
     
        cell.avatarImageView.image = UIImage(named: "new_group_40x40_")
        cell.groupNameLabel.text = "群组1"
        cell.abstractLabel.text = "明日会议取消"
        cell.timeLabel.text = "10:33"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消点击行则选中的状态
        self.tableView.deselectRow(at: indexPath, animated: true)
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
