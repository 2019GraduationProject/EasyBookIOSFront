//
//  GlobalDiscoverController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/10.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class GlobalDiscoverController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let globalEventData: [Event] = [
        Event(name: "机器学习讲座", date: EventDate(monthAndDay: "03-20"), location: "南京大学鼓楼校区教学楼201", group: ["全部用户"], clause: [Clause(startTime: "14:00", endTime: "16:00")]),
        Event(name: "大数据时代讲座", date: EventDate(monthAndDay: "04-01"), location: "南京大学鼓楼校区教学楼220", group: ["全部用户"], clause: [Clause(startTime: "09:00", endTime: "11:00")])
    ]
    
    // 保存搜索结果
    var eventSearchResult: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 去掉 tableview 多余的分割线
        self.tableView.tableFooterView = UIView.init()
        
        // 搜索内容为空时，显示全部内容
        self.eventSearchResult = self.globalEventData
        searchBar.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.resignFirstResponder()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    
    // MARK: - UISearchBarDelegate
    
    /// 每次改变搜索内容时候调用此方法
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.eventSearchResult = self.globalEventData
        } else {
            eventSearchResult = globalEventData.filter({ (eventData) -> Bool in
                return eventData.name.localizedCaseInsensitiveContains(searchText)
            })
        }
        self.tableView.reloadData()
    }
    
    /// 搜索触发事件，点击虚拟键盘上的 search 按钮时触发此方法
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventSearchResult.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = String(describing: DetailEventCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! DetailEventCell
        
        cell.monthDayLabel.text = eventSearchResult[indexPath.row].date.monthAndDay
        cell.yearLabel.text = eventSearchResult[indexPath.row].date.year
        cell.eventNameLabel.text = eventSearchResult[indexPath.row].name
        cell.groupNameLabel.text = eventSearchResult[indexPath.row].group.joined(separator: ", ")
        cell.locationLabel.text = eventSearchResult[indexPath.row].location

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消点击行则选中的状态
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if let eventDetailNaviController = self.storyboard?.instantiateViewController(withIdentifier: "EventDetailNaviController") as? UINavigationController {
            let eventDetailVC = eventDetailNaviController.topViewController as! EventDetailController
            let eventInfo = self.eventSearchResult[indexPath.row]
            eventDetailVC.eventInfo = eventInfo
            
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
