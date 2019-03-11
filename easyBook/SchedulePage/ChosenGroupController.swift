//
//  ChosenGroupController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/8.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class ChosenGroupController: UITableViewController {
    
    var chosenGroupList: [String]!
    var chosenGroupDic = Dictionary<String, Bool>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.sectionFooterHeight = 8
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosenGroupList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = String(describing: MyGroupCell.self)
        let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MyGroupCell
        
        cell.groupNameLabel.text = chosenGroupList[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "删除") { (_, _, completion) in
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            // 更新 chosenGroupDic
            let cell = tableView.cellForRow(at: indexPath) as! MyGroupCell
            self.chosenGroupDic.updateValue(false, forKey: cell.groupNameLabel.text!)
            
            // 收起滑动侧边栏
            completion(true)
        }
        deleteAction.image = UIImage(named: "delete_24x24_")
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消点击行则选中的状态
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /// 修改每个 section 的 header 的高度
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
    // MARK: - Event Listeners
    
    @IBAction func tapCancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapDoneButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    ////    let createdGroupNameList = ["机器学习", "软工大作业"]
    ////    let attendedGroupNameList = ["出国留学申请", "movies", "本科毕设", "设计design"]
    //
    //    var createdGroupChosenList: [String]!
    //    var attendedGroupChosenList: [String]!
    //    var chosenGroupDic = Dictionary<String, Bool>()
    //
    //
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //
    //        tableView.sectionFooterHeight = 0
    //    }
    //
    ////    func updateChosenList() {
    ////        createdGroupChosenList.removeAll()
    ////        attendedGroupChosenList.removeAll()
    ////
    ////        for group in createdGroupNameList {
    ////            if chosenGroupDic[group]! {
    ////                createdGroupChosenList.append(group)
    ////            }
    ////        }
    ////        for group in attendedGroupNameList {
    ////            if chosenGroupDic[group]! {
    ////                attendedGroupChosenList.append(group)
    ////            }
    ////        }
    ////    }
    //
    //    // MARK: - Table view data source
    //
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        if createdGroupChosenList.count == 0 && attendedGroupChosenList.count == 0 {
    //            return 0
    //        } else if createdGroupChosenList.count > 0 && attendedGroupChosenList.count > 0 {
    //            return 2
    //        } else {
    //            return 1
    //        }
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        if createdGroupChosenList.count > 0 && attendedGroupChosenList.count == 0 {
    //            return createdGroupChosenList.count
    //        }
    //        else if createdGroupChosenList.count == 0 && attendedGroupChosenList.count > 0 {
    //            return attendedGroupChosenList.count
    //        }
    //        else if createdGroupChosenList.count > 0 && attendedGroupChosenList.count > 0 {
    //            switch section {
    //            case 0:
    //                return createdGroupChosenList.count
    //            default:
    //                return attendedGroupChosenList.count
    //            }
    //        } else {
    //            return 0
    //        }
    //    }
    //
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        if createdGroupChosenList.count > 0 && attendedGroupChosenList.count == 0 {
    //            let reuseIdentifier = String(describing: SelectedGroupCell.self)
    //            let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SelectedGroupCell
    //
    //            cell.groupNameLabel.text = createdGroupChosenList[indexPath.row]
    //
    //            return cell
    //        }
    //        else if createdGroupChosenList.count == 0 && attendedGroupChosenList.count > 0 {
    //            let reuseIdentifier = String(describing: SelectedGroupCell.self)
    //            let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SelectedGroupCell
    //
    //            cell.groupNameLabel.text = attendedGroupChosenList[indexPath.row]
    //
    //            return cell
    //        }
    //        else if createdGroupChosenList.count > 0 && attendedGroupChosenList.count > 0 {
    //            switch indexPath.section {
    //            case 0:
    //                let reuseIdentifier = String(describing: SelectedGroupCell.self)
    //                let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SelectedGroupCell
    //
    //                cell.groupNameLabel.text = createdGroupChosenList[indexPath.row]
    //
    //                return cell
    //            default:
    //                let reuseIdentifier = String(describing: SelectedGroupCell.self)
    //                let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SelectedGroupCell
    //
    //                cell.groupNameLabel.text = attendedGroupChosenList[indexPath.row]
    //
    //                return cell
    //            }
    //        } else {
    //            return UITableViewCell(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    //        }
    //    }
    //
    //    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //        let deleteAction = UIContextualAction(style: .destructive, title: "删除") { (_, _, completion) in
    ////            self.tableView.deleteRows(at: [indexPath], with: .automatic)
    //            // 更新 chosenGroupDic
    //            let cell = tableView.cellForRow(at: indexPath) as! SelectedGroupCell
    //            self.chosenGroupDic.updateValue(false, forKey: cell.groupNameLabel.text!)
    //
    ////            self.updateChosenList()
    ////            self.tableView.reloadData()
    //
    //            // 收起滑动侧边栏
    //            completion(true)
    //        }
    //        deleteAction.image = UIImage(named: "delete_24x24_")
    //
    //        let config = UISwipeActionsConfiguration(actions: [deleteAction])
    //        return config
    //    }
    //
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        // 取消点击行则选中的状态
    //        self.tableView.deselectRow(at: indexPath, animated: true)
    //    }
    //
    //    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        if createdGroupChosenList.count > 0 && attendedGroupChosenList.count == 0 {
    //            return "我创建的群组"
    //        }
    //        else if createdGroupChosenList.count == 0 && attendedGroupChosenList.count > 0 {
    //            return "我加入的群组"
    //        }
    //        else if createdGroupChosenList.count > 0 && attendedGroupChosenList.count > 0 {
    //            switch section {
    //            case 0:
    //                return "我创建的群组"
    //            default:
    //                return "我加入的群组"
    //            }
    //        } else {
    //            return nil
    //        }
    //    }
    //
    //    /// 修改每个 section 的 header 的高度
    //    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 30
    //    }

}
