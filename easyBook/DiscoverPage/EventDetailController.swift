//
//  EventDetailController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/11.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class EventDetailController: UITableViewController {
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var eventInfo: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.sectionFooterHeight = 0
        
        eventNameLabel.text = eventInfo.name
        eventDateLabel.text = eventInfo.date.year + "-" + eventInfo.date.monthAndDay
        locationLabel.text = eventInfo.location
        
        // 设置多行文本在 label 中自动换行
        eventNameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        eventNameLabel.numberOfLines = 0
        locationLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        locationLabel.numberOfLines = 0
        
        // 创建重用的单元格
        self.tableView.register(UINib(nibName: "DetailGroupCell", bundle: nil), forCellReuseIdentifier: "DetailGroupCell")
        self.tableView.register(UINib(nibName: "DetailClauseCell", bundle: nil), forCellReuseIdentifier: "DetailClauseCell")
    }
    
    /// 取消 section 的点击效果
    /// ⚠️注：若在viewDidLoad()中写，则还未加载到第一个section，会报空指针
    ///
    /// - Parameter animated: Bool
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for x in 0...(tableView(self.tableView, numberOfRowsInSection: 0) - 1) {
            tableView.cellForRow(at: [0, x])?.selectionStyle = .none
        }
        
        for x in 0...(tableView(self.tableView, numberOfRowsInSection: 2) - 1) {
            tableView.cellForRow(at: [2, x])?.selectionStyle = .none
        }
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return eventInfo.group.count
        } else if section == 2 {
            return eventInfo.clause.count
        } else {
            return super.tableView(self.tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let reuseIdentifier = String(describing: DetailGroupCell.self)
            let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! DetailGroupCell

            cell.groupNameLabel.text = eventInfo.group[indexPath.row]
            return cell
        }
        else if indexPath.section == 2 {
            let reuseIdentifier = String(describing: DetailClauseCell.self)
            let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! DetailClauseCell
            
            if eventInfo.clause.count > 1 {
                cell.timePeriodLabel.text = "时间段" + (indexPath.row + 1).description + "："
            }
            cell.startTimeLabel.text = eventInfo.clause[indexPath.row].startTime
            cell.endTimeLabel.text = eventInfo.clause[indexPath.row].endTime
            return cell
        }
        else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    /// 因为动态添加分区单元格，会引起cell高度的变化，所以要重新设置
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 || indexPath.section == 2 {
            return 56
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    /// 当覆盖了静态的 cell 数据源方法时需要提供一个代理方法,
    /// 因为数据源对新加进来的 cell 一无所知，所以要使用这个代理方法
    override func tableView(_ tableView: UITableView,
                            indentationLevelForRowAt indexPath: IndexPath) -> Int {
        if indexPath.section == 1 || indexPath.section == 2 {
            let newIndexPath = IndexPath(row: 0, section: indexPath.section)
            return super.tableView(tableView, indentationLevelForRowAt: newIndexPath)
        } else {
            return super.tableView(tableView, indentationLevelForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消点击行则选中的状态
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /// 修改每个section之间的间距：修改section的header的大小
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    // MARK: - Event Listeners

    @IBAction func tapBackButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
