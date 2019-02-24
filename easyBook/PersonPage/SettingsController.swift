//
//  SettingsController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/1/23.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class SettingsController: UITableViewController {
    
    var naviBarShadowImage = UIImage(named: "separator") // 存储导航条图片
    var initialOffsetY : CGFloat! // 初始位移量
    var isInitialCompute = true // 是否是第一次计算初始位移的标志
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "设置"
        // 设置导航条标题字体颜色为黑色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        // 修改每个 section 之间的间距：修改 section 的 footer 的大小
        tableView.sectionFooterHeight = 8
    }
    
    /// 去掉子页面返回按钮后的文字
    ///
    /// - Parameter animated:
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 设置返回按钮后的文字
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
    
    
    // MARK: - Table View Functions
    
    /// 修改每个section之间的间距：修改section的header的大小
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消点击行则选中的状态
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        // 点击退出登录行
        if indexPath.section == 2 {
            let actionSheet = UIAlertController(title: nil, message: "退出后不会删除任何历史数据，下次登录依然可以使用本账号。", preferredStyle: .actionSheet)
            
            let logoutAction = UIAlertAction(title: "退出登录", style: .destructive) { (_) in
                if let loginNaviController = self.storyboard?.instantiateViewController(withIdentifier: "LoginNaviController") as? UINavigationController {
                    self.present(loginNaviController, animated: true, completion: {
                        UserDefaults.standard.set(false, forKey: "ifLogin")
                    })
                }
            }
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            
            actionSheet.addAction(logoutAction)
            actionSheet.addAction(cancelAction)
            
            present(actionSheet, animated: true, completion: nil)
        }
    }
    
    // MARK: - Event Listeners
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
