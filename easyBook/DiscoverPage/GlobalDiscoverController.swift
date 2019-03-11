//
//  GlobalDiscoverController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/10.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class GlobalDiscoverController: UITableViewController {
    
    let globalEventData: [Event] = [
        Event(name: "机器学习讲座", date: EventDate(monthAndDay: "03-20"), location: "南京大学鼓楼校区教学楼201", group: ["全部用户"], clause: [Clause(startTime: "14:00", endTime: "16:00")]),
        Event(name: "大数据时代讲座", date: EventDate(monthAndDay: "04-01"), location: "南京大学鼓楼校区教学楼220", group: ["全部用户"], clause: [Clause(startTime: "09:00", endTime: "11:00")])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 去掉 tableview 多余的分割线
        self.tableView.tableFooterView = UIView.init()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalEventData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = String(describing: DetailEventCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! DetailEventCell
        
        cell.monthDayLabel.text = globalEventData[indexPath.row].date.monthAndDay
        cell.yearLabel.text = globalEventData[indexPath.row].date.year
        cell.eventNameLabel.text = globalEventData[indexPath.row].name
        cell.groupNameLabel.text = globalEventData[indexPath.row].group.joined(separator: ", ")
        cell.locationLabel.text = globalEventData[indexPath.row].location

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消点击行则选中的状态
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if let eventDetailNaviController = self.storyboard?.instantiateViewController(withIdentifier: "EventDetailNaviController") as? UINavigationController {
            eventDetailNaviController.modalTransitionStyle = .coverVertical
            present(eventDetailNaviController, animated: true, completion: nil)
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
