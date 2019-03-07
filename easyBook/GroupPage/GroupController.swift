//
//  GroupController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/1/22.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

/// ⚠️注：由于使用了 Search Bar and Search Display Controller 组件，
///      所有的 tableView 引用都要加上self.tableView，否则程序会崩溃
class GroupController: UITableViewController {
    
    @IBOutlet weak var groupSearchBar: UISearchBar!
    
    var naviBarShadowImage = UIImage(named: "separator") // 存储导航条图片
    var initialOffsetY : CGFloat! // 初始位移量
    var isInitialCompute = true // 是否是第一次计算初始位移的标志
    
    var actionImgList = ["new_invitation_40x40_","new_group_40x40_"]
    var actionTitleList = ["新的邀请", "新建群组"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置导航条背景透明
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // 去掉 search bar 上下两边的分割线
        groupSearchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 去掉第一个 section 最上方的分割线
        if let cell = tableView.cellForRow(at: [0, 0]) {
            var seperatorId = 0
            for subView in cell.subviews {
                if subView.bounds.height < 1 {
                    if seperatorId == 1 {
                        subView.isHidden = true
                        break
                    }
                    seperatorId += 1
                }
            }
//            cell.subviews.forEach { (subView) in // 去掉第一个 section 每条分割线
//                if subView.bounds.height < 1 {
//                    subView.isHidden = true
//                }
//            }
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

    
    // MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        default:
            return 5
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let reuseIdentifier = String(describing: GroupBasicCell.self)
            let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! GroupBasicCell

            cell.titleImageView.image = UIImage(named: actionImgList[indexPath.row])
            cell.titleLabel.text = actionTitleList[indexPath.row]

            return cell
        case 1:
            let reuseIdentifier = String(describing: GroupBasicCell.self)
            let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! GroupBasicCell
            
            cell.titleImageView.image = UIImage(named: "default_group_avatar_40x40_")
            cell.titleLabel.text = "群组1"
            
            return cell
        default:
            let reuseIdentifier = String(describing: GroupBasicCell.self)
            let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! GroupBasicCell
            
            cell.titleImageView.image = UIImage(named: "default_group_avatar_40x40_")
            cell.titleLabel.text = "群组2"
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消点击行则选中的状态
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /// 创建每个section的顶端label
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - section: section的ID
    /// - Returns: headerView
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        
        let headerLabel = UILabel(frame: CGRect(x: 20, y: 0, width: 100, height: 22))
        headerLabel.textColor = UIColor(named: "themeGray")
        headerLabel.font = UIFont.systemFont(ofSize: 11)
        headerView.addSubview(headerLabel)
        
        switch section {
        case 1:
            headerLabel.text = "我创建的群组"
        case 2:
            headerLabel.text = "我加入的群组"
        default:
            break
        }
        
        return headerView
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
