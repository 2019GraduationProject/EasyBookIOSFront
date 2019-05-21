//
//  MyPublishController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/18.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit
import FSCalendar

class MyPublishController: UITableViewController {
    
    var naviBarShadowImage = UIImage(named: "separator") // 存储导航条图片
    var initialOffsetY : CGFloat! // 初始位移量
    var isInitialCompute = true // 是否是第一次计算初始位移的标志
    
    var myEventData: [Event] = [
        Event(name: "预答辩交流会", date: EventDate(monthAndDay: "05-21"), location: "南京大学软件学院院楼603", group: ["软工大作业"], clause: [Clause(startTime: "13:00", endTime: "14:00", maxAmount: 3, currentAmount: 1), Clause(startTime: "15:00", endTime: "16:00", maxAmount: 3, currentAmount: 0)]),
        Event(name: "大数据时代讲座", date: EventDate(monthAndDay: "04-01"), location: "南京大学鼓楼校区教学楼220", group: ["全部用户"], clause: [Clause(startTime: "09:00", endTime: "11:00", maxAmount: 250, currentAmount: 120), Clause(startTime: "13:30", endTime: "15:00", maxAmount: 3, currentAmount: 0)], isOver: true),
        Event(name: "机器学习讲座", date: EventDate(monthAndDay: "03-20"), location: "南京大学鼓楼校区教学楼201", group: ["全部用户"], clause: [Clause(startTime: "14:00", endTime: "16:00", maxAmount: 200, currentAmount: 200)], isOver: true),
        Event(name: "本科毕业设计", date: EventDate(monthAndDay: "02-28"), location: "南京大学软件学院院楼710", group: ["预约访谈app组", "微信小程序组"], clause: [Clause(startTime: "14:00", endTime: "15:00", maxAmount: 3, currentAmount: 0), Clause(startTime: "15:00", endTime: "16:00", maxAmount: 3, currentAmount: 1)], isOver: true)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "我的发布"
        // 设置导航条标题字体颜色为黑色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        
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
        return myEventData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if myEventData[indexPath.row].isOver {
            let reuseIdentifier = String(describing: EndedEventCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EndedEventCell
            
            cell.monthDayLabel.text = myEventData[indexPath.row].date.monthAndDay
            cell.yearLabel.text = myEventData[indexPath.row].date.year
            cell.eventNameLabel.text = myEventData[indexPath.row].name
            cell.groupNameLabel.text = myEventData[indexPath.row].group.joined(separator: ", ")
            cell.locationLabel.text = myEventData[indexPath.row].location
            
            return cell
        } else {
            let reuseIdentifier = String(describing: DetailEventCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! DetailEventCell
            
            cell.monthDayLabel.text = myEventData[indexPath.row].date.monthAndDay
            cell.yearLabel.text = myEventData[indexPath.row].date.year
            cell.eventNameLabel.text = myEventData[indexPath.row].name
            cell.groupNameLabel.text = myEventData[indexPath.row].group.joined(separator: ", ")
            cell.locationLabel.text = myEventData[indexPath.row].location
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消点击行则选中的状态
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /// 已经结束的事件才可以删除
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return myEventData[indexPath.row].isOver
    }
    
    /// 每行右往左滑监听
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "删除") { (_, _, completion) in
            self.myEventData.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            // 收起滑动侧边栏
            completion(true)
        }
        deleteAction.image = UIImage(named: "delete_24x24_")
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    

    // MARK: - Navigation
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row = tableView.indexPathForSelectedRow!.row
        let eventInfo = self.myEventData[row]
        
        if segue.identifier == "toUpcomingEventDetail" {
            let upcomingEventDetailVC = segue.destination as! UpcomingEventDetailController
            upcomingEventDetailVC.eventInfo = eventInfo
        }
        else if segue.identifier == "toEndedEventDetail" {
            let endedEventDetailVC = segue.destination as! EndedEventDetailController
            endedEventDetailVC.eventInfo = eventInfo
        }
    }
    
}
