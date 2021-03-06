//
//  EndedEventDetailController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/18.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class EndedEventDetailController: UITableViewController {
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var naviBarShadowImage = UIImage(named: "separator") // 存储导航条图片
    var initialOffsetY : CGFloat! // 初始位移量
    var isInitialCompute = true // 是否是第一次计算初始位移的标志
    
    var eventInfo: Event!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "详情"
        // 设置导航条标题字体颜色为黑色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        navigationController?.navigationBar.shadowImage = naviBarShadowImage
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        
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
        self.tableView.register(UINib(nibName: "EndedClauseCell", bundle: nil), forCellReuseIdentifier: "EndedClauseCell")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
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
            let reuseIdentifier = String(describing: EndedClauseCell.self)
            let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EndedClauseCell
            
            if eventInfo.clause.count > 1 {
                cell.timePeriodLabel.text = "时间段" + (indexPath.row + 1).description
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

}
