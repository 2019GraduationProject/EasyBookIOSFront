//
//  ScheduleDetailController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/12.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class ScheduleDetailController: UITableViewController {

    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var scheduleInfo: ScheduleEvent!
    
    var naviBarShadowImage = UIImage(named: "separator") // 存储导航条图片
    var initialOffsetY: CGFloat! // 初始位移量
    var isInitialCompute = true // 是否是第一次计算初始位移的标志
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.sectionFooterHeight = 0
        self.navigationItem.title = "预约详情"
        // 设置导航条标题字体颜色为黑色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        
        // 设置返回按钮颜色
        navigationController?.navigationBar.tintColor = UIColor(named: "themeDarkBlack")
        
        // 设置导航条背景透明
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // 设置事件数据内容
        eventNameLabel.text = scheduleInfo.name
        dateLabel.text = scheduleInfo.date
        startTimeLabel.text = scheduleInfo.startTime
        endTimeLabel.text = scheduleInfo.endTime
        locationLabel.text = scheduleInfo.location
        
        // 设置多行文本在 label 中自动换行
        locationLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        locationLabel.numberOfLines = 0
        eventNameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        eventNameLabel.numberOfLines = 0
        
        // 创建重用的单元格
        self.tableView.register(UINib(nibName: "DetailGroupCell", bundle: nil), forCellReuseIdentifier: "DetailGroupCell")
    }
    
    /// 去掉子页面返回按钮后的文字
    ///
    /// - Parameter animated:
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 设置返回按钮后的文字
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
        
        if scheduleInfo.group.count == 1 && scheduleInfo.group[0] == "全部用户" {
            tableView.cellForRow(at: [1, 0])?.selectionStyle = .none
        }
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
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return scheduleInfo.group.count
        } else {
            return super.tableView(self.tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let reuseIdentifier = String(describing: DetailGroupCell.self)
            let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! DetailGroupCell
            
            if scheduleInfo.group[indexPath.row] == "全部用户" {
                cell.detailBtn.isHidden = true
            }
            cell.groupNameLabel.text = scheduleInfo.group[indexPath.row]
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
            let cell  = tableView.cellForRow(at: indexPath) as! DetailGroupCell
            if cell.groupNameLabel.text == "全部用户" {
                return
            }
            else {
                if let groupInfoVC = self.storyboard?.instantiateViewController(withIdentifier: "GroupInfoController") as? GroupInfoController {
                    groupInfoVC.groupName = scheduleInfo.group[indexPath.row]
                    self.navigationController?.pushViewController(groupInfoVC, animated: true)
                }
            }
        }
    }
    
    /// 修改每个section之间的间距：修改section的header的大小
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    

}
