//
//  AddLocalEventController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/5.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class AddLocalEventController: UITableViewController {
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventLocationTextField: UITextField!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    @IBOutlet weak var chosenGroupLabel: UILabel!
    
    let createdGroupNameList = ["机器学习", "软工大作业"]
    let attendedGroupNameList = ["出国留学申请", "movies", "本科毕设", "设计design"]
    
    var clauseNum: Int! // 条目数量
    var chosenGroupDic = Dictionary<String, Bool>()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    var eventDate: Date = Date() {
        didSet {
            self.eventDateLabel.text = self.dateFormatter.string(from: eventDate)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        clauseNum = 1 // 默认新建一个条目
        
        // 初始化字典
        for group in createdGroupNameList {
            chosenGroupDic.updateValue(false, forKey: group)
        }
        for group in attendedGroupNameList {
            chosenGroupDic.updateValue(false, forKey: group)
        }
        
        // 创建重用的单元格
        self.tableView.register(UINib(nibName: "ClauseCell", bundle: nil), forCellReuseIdentifier: "ClauseCell")
        
        // 修改每个 section 之间的间距：修改 section 的 footer 的大小
        tableView.sectionFooterHeight = 0
        // 初始化 eventDateLabel 的日期为今日
        eventDate = Date()
        // 给 datePicker 加监听
        eventDatePicker.addTarget(self, action: #selector(chooseEventDate( _:)), for: UIControl.Event.valueChanged)
    }
    
    /// 取消 section 的点击效果
    /// ⚠️注：若在viewDidLoad()中写，则还未加载到第一个section，会报空指针
    ///
    /// - Parameter animated: Bool
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for x in 0...(tableView.numberOfSections -  1) {
            for y in 0...(tableView(self.tableView, numberOfRowsInSection: x) - 1) {
                if x != 1 { // 不需要取消第二个 section 中的 cell 的点击效果
                    tableView.cellForRow(at: [x, y])?.selectionStyle = .none
                }
            }
        }
        // 添加条目按钮需要有点击效果
        tableView.cellForRow(at: [2, 0])?.selectionStyle = .default
    }
    
    /// 滑动屏幕取消输入框光标
    ///
    /// - Parameter scrollView: scrollView
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if eventNameTextField.isFirstResponder {
            eventNameTextField.resignFirstResponder()
        }
        else if eventLocationTextField.isFirstResponder {
            eventLocationTextField.resignFirstResponder()
        }
    }
    
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return clauseNum + 1
        } else {
            return super.tableView(self.tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 第一个 cell 是添加条目按钮
        if indexPath.section == 2 && indexPath.row >= 1 {
            let reuseIdentifier = String(describing: ClauseCell.self)
            let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ClauseCell
            cell.timePeriodLabel.text = "时间段" + indexPath.row.description
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    /// 因为第三个分区单元格动态添加，会引起 cell 高度的变化，所以要重新设置
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 && indexPath.row >= 1 {
            return 176
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    /// 当覆盖了静态的 cell 数据源方法时需要提供一个代理方法,
    /// 因为数据源对新加进来的 cell 一无所知，所以要使用这个代理方法
    override func tableView(_ tableView: UITableView,
                            indentationLevelForRowAt indexPath: IndexPath) -> Int {
        if indexPath.section == 2 && indexPath.row >= 1 {
            // 当执行到日期选择器所在的 indexPat h就创建一个 indexPath 然后强插
            let newIndexPath = IndexPath(row: 1, section: indexPath.section)
            return super.tableView(tableView, indentationLevelForRowAt: newIndexPath)
        } else {
            return super.tableView(tableView, indentationLevelForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消点击行则选中的状态
        self.tableView.deselectRow(at: indexPath, animated: true)
        // 增加一个条目
        if indexPath.section == 2 && indexPath.row == 0 {
            clauseNum += 1
            let newIndexPath = IndexPath(row: clauseNum, section: indexPath.section)
            self.tableView.insertRows(at: [newIndexPath], with: .automatic)
            // 让 tableView 有一个自动滑动到底端的效果
            self.tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
    }
    
    /// 设置条目行可滑动删除，别的行不可滑动
    ///
    /// - Parameters:
    ///   - tableView: tableView
    ///   - indexPath: indexPath
    /// - Returns: 是否能编辑行
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // 每个事件必须至少有一个条目，所以第一个条目不可删除
        if indexPath.section == 2 && indexPath.row > 1 {
            return true
        } else {
            return false
        }
    }
    
    /// 当条目数目大于1时，可滑动删除
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section == 2 && indexPath.row > 1 {
            let deleteAction = UIContextualAction(style: .destructive, title: "删除") { (_, _, completion) in
                self.clauseNum -= 1
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                // 收起滑动侧边栏
                completion(true)
            }
            deleteAction.image = UIImage(named: "delete_24x24_")
            
            let config = UISwipeActionsConfiguration(actions: [deleteAction])
            return config
        } else {
            return nil
        }
    }
    
    /// 修改每个section之间的间距：修改section的header的大小
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    
    // MARK: - Event Listeners

    @IBAction func tapCanelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func tapDeliverButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func chooseEventDate(_ datePicker: UIDatePicker) {
        self.eventDate = datePicker.date
    }
    
    
    // MARK: - Navigation
 
    @IBAction func backToAddLocalEvent(segue: UIStoryboardSegue) {
        if segue.identifier == "chooseToAdd" {
            let chooseGroupVC = segue.source as! ChooseGroupController
            self.chosenGroupDic = chooseGroupVC.chosenGroupDic
        }
        else if segue.identifier == "chosenToAdd" {
            let chosenGroupVC = segue.source as! ChosenGroupController
            self.chosenGroupDic = chosenGroupVC.chosenGroupDic
        }
        
        var chosenGroupsName = ""
        var isEmpty = true
        
        for item in chosenGroupDic {
            if item.value {
                isEmpty = false
                chosenGroupsName += item.key
                chosenGroupsName += ", "
            }
        }
        // 去掉空格和最后一个逗号
        if !isEmpty {
            chosenGroupsName = String(chosenGroupsName.trimmingCharacters(in: .whitespaces).prefix(chosenGroupsName.count - 2))
            chosenGroupLabel.text = chosenGroupsName
        } else {
            chosenGroupLabel.text = "无已选择的群组"
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChooseGroup" {
            let destination = segue.destination as! UINavigationController
            let chooseGroupVC = destination.topViewController as! ChooseGroupController
            chooseGroupVC.chosenGroupDic = self.chosenGroupDic
        }
        else if segue.identifier == "toChosenGroup" {
            let destination = segue.destination as! UINavigationController
            let chosenGroupVC = destination.topViewController as! ChosenGroupController
            
//            var createdGroupChosenList: [String] = []
//            var attendedGroupChosenList: [String] = []
            var chosenGroupList: [String] = []
            
            for group in createdGroupNameList {
                if chosenGroupDic[group]! {
                    chosenGroupList.append(group)
                }
            }
            for group in attendedGroupNameList {
                if chosenGroupDic[group]! {
                    chosenGroupList.append(group)
                }
            }
            
            chosenGroupVC.chosenGroupDic = self.chosenGroupDic
            chosenGroupVC.chosenGroupList = chosenGroupList
//            chosenGroupVC.createdGroupChosenList = createdGroupChosenList
//            chosenGroupVC.attendedGroupChosenList = attendedGroupChosenList
        }
    }
    
}
