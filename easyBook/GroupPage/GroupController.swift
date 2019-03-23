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
class GroupController: UITableViewController, UISearchResultsUpdating {
    
    var searchController: UISearchController!
    
    var naviBarShadowImage = UIImage(named: "separator") // 存储导航条图片
    var initialOffsetY: CGFloat! // 初始位移量
    var isInitialCompute = true // 是否是第一次计算初始位移的标志
    
    let actionImgList = ["new_invitation_40x40_","new_group_40x40_"]
    let actionTitleList = ["新的邀请", "新建群组"]
    let createdGroupNameList = ["机器学习", "软工大作业"]
    let attendedGroupNameList = ["出国留学申请", "movies", "本科毕设", "设计design"]
    
    // 保存搜索结果
    var createdSearchResult: [String] = []
    var attendedSearchResult: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置导航条背景透明
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // 修改每个 section 之间的间距：修改 section 的 footer 的大小
        tableView.sectionFooterHeight = 0
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        tableView.tableHeaderView = searchController.searchBar
        
        // 设置搜索条外观
        searchController.searchBar.tintColor = UIColor(named: "themeColor")
        searchController.searchBar.placeholder = "搜索群组"
        searchController.searchBar.searchBarStyle = .minimal
        searchController.dimsBackgroundDuringPresentation = false // 搜索背景不变暗
        
        
        // 去掉 search bar 上下两边的分割线
//        groupSearchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 去掉第一个 section 最上方的分割线
        if let cell = self.tableView.cellForRow(at: [0, 0]) {
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
    
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        if var text = searchController.searchBar.text {
            text = text.trimmingCharacters(in: .whitespaces)
            searchFilter(text: text)
            tableView.reloadData()
        }
    }
    
    func searchFilter(text: String) {
        createdSearchResult = createdGroupNameList.filter({ (groupName) -> Bool in
            return groupName.localizedCaseInsensitiveContains(text)
        })
        
        attendedSearchResult = attendedGroupNameList.filter({ (groupName) -> Bool in
            return groupName.localizedCaseInsensitiveContains(text)
        })
    }

    
    // MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return searchController.isActive ? 2 : 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            if section == 0 {
                return createdSearchResult.count
            } else {
                return attendedSearchResult.count
            }
        } else {
            switch section {
            case 0:
                return 2
            case 1:
                return createdGroupNameList.count
            default:
                return attendedGroupNameList.count
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchController.isActive {
            if indexPath.section == 0 {
                let reuseIdentifier = String(describing: MyGroupCell.self)
                let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MyGroupCell
                
                cell.groupNameLabel.text = createdSearchResult[indexPath.row]
                
                return cell
            } else {
                let reuseIdentifier = String(describing: MyGroupCell.self)
                let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MyGroupCell
                
                cell.groupNameLabel.text = attendedSearchResult[indexPath.row]
                
                return cell
            }
        } else {
            switch indexPath.section {
            case 0:
                let reuseIdentifier = String(describing: GroupBasicCell.self)
                let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! GroupBasicCell
                
                cell.titleImageView.image = UIImage(named: actionImgList[indexPath.row])
                cell.titleLabel.text = actionTitleList[indexPath.row]
                
                return cell
            case 1:
                let reuseIdentifier = String(describing: MyGroupCell.self)
                let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MyGroupCell
                
                cell.groupNameLabel.text = createdGroupNameList[indexPath.row]
                
                return cell
            default:
                let reuseIdentifier = String(describing: MyGroupCell.self)
                let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MyGroupCell
                
                cell.groupNameLabel.text = attendedGroupNameList[indexPath.row]
                
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消点击行则选中的状态
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            if let myGroupDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MyGroupDetailController") as? MyGroupDetailController {
                if searchController.isActive {
                    myGroupDetailVC.groupName = createdSearchResult[indexPath.row]
                } else {
                    myGroupDetailVC.groupName = createdGroupNameList[indexPath.row]
                }
                self.navigationController?.pushViewController(myGroupDetailVC, animated: true)
            }
        }
        else if indexPath.section == 2 {
            if let groupDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "GroupDetailController") as? GroupDetailController {
                if searchController.isActive {
                    groupDetailVC.groupName = attendedSearchResult[indexPath.row]
                } else {
                    groupDetailVC.groupName = attendedGroupNameList[indexPath.row]
                }
                self.navigationController?.pushViewController(groupDetailVC, animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchController.isActive {
            if section == 0 && createdSearchResult.count > 0 {
                return "我创建的群组"
            } else if (section == 1 && attendedSearchResult.count > 0) {
                return "我加入的群组"
            } else {
                return nil
            }
        } else {
            switch section {
            case 1:
                return "我创建的群组"
            case 2:
                return "我加入的群组"
            default:
                return nil
            }
        }
    }
    
    /// 修改每个 section 的 header 的高度
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 30
        }
    }
    
    /// 创建每个section的顶端label
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - section: section的ID
    /// - Returns: headerView
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.clear
//
//        let headerLabel = UILabel(frame: CGRect(x: 20, y: 0, width: 100, height: 22))
//        headerLabel.textColor = UIColor(named: "themeGray")
//        headerLabel.font = UIFont.systemFont(ofSize: 11)
//        headerView.addSubview(headerLabel)
//
//        switch section {
//        case 1:
//            headerLabel.text = "我创建的群组"
//        case 2:
//            headerLabel.text = "我加入的群组"
//        default:
//            break
//        }
//
//        return headerView
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
