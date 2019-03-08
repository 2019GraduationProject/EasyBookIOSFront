//
//  ChooseGroupController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/8.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class ChooseGroupController: UITableViewController {
    
    let createdGroupNameList = ["机器学习", "软工大作业"]
    let attendedGroupNameList = ["出国留学申请", "movies", "本科毕设", "设计design"]
    var chosenGroupDic = Dictionary<String, Bool>()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.sectionFooterHeight = 0
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return createdGroupNameList.count
        default:
            return attendedGroupNameList.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let reuseIdentifier = String(describing: SelectGroupCell.self)
            let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SelectGroupCell
            
            cell.groupNameLabel.text = createdGroupNameList[indexPath.row]
            if chosenGroupDic[createdGroupNameList[indexPath.row]]! {
                cell.checkBox.on = true
            }
            
            return cell
        default:
            let reuseIdentifier = String(describing: SelectGroupCell.self)
            let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SelectGroupCell
            
            cell.groupNameLabel.text = attendedGroupNameList[indexPath.row]
            if chosenGroupDic[attendedGroupNameList[indexPath.row]]! {
                cell.checkBox.on = true
            }
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消点击行则选中的状态
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! SelectGroupCell
        if cell.checkBox.on {
            cell.checkBox.setOn(false, animated: true)
            chosenGroupDic.updateValue(false, forKey: cell.groupNameLabel.text!)
        } else {
            cell.checkBox.setOn(true, animated: true)
            chosenGroupDic.updateValue(true, forKey: cell.groupNameLabel.text!)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "我创建的群组"
        default:
            return "我加入的群组"
        }
    }
    
    /// 修改每个 section 的 header 的高度
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
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

}
