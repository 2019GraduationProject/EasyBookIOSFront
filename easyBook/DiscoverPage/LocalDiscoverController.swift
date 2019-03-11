//
//  LocalDiscoverController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/10.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class LocalDiscoverController: UITableViewController {
    
    let localEventData: [Event] = [
        Event(name: "本科毕业设计", date: EventDate(monthAndDay: "03-15"), location: "南京大学软件学院院楼710", group: ["预约访谈app组"], clause: [Clause(startTime: "15:00", endTime: "16:00")]),
        Event(name: "软件工程与计算II小组会", date: EventDate(monthAndDay: "03-23"), location: "南大仙林图书馆220", group: ["电影网站组"], clause: [Clause(startTime: "13:30", endTime: "17:00")]),
        Event(name: "EL游戏设计比赛小组会", date: EventDate(monthAndDay: "03-30"), location: "南大仙林图书馆202", group: ["EL游戏设计组"], clause: [Clause(startTime: "13:00", endTime: "17:30")])
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
        return localEventData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = String(describing: DetailEventCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! DetailEventCell
        
        cell.monthDayLabel.text = localEventData[indexPath.row].date.monthAndDay
        cell.yearLabel.text = localEventData[indexPath.row].date.year
        cell.eventNameLabel.text = localEventData[indexPath.row].name
        cell.groupNameLabel.text = localEventData[indexPath.row].group.joined(separator: ", ")
        cell.locationLabel.text = localEventData[indexPath.row].location

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
