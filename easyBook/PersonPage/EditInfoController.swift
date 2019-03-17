//
//  EditInfoController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/1/23.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class EditInfoController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var briefIntroLabel: UILabel!
    
    var naviBarShadowImage = UIImage(named: "separator") // 存储导航条图片
    var initialOffsetY : CGFloat! // 初始位移量
    var isInitialCompute = true // 是否是第一次计算初始位移的标志
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "修改信息"
        // 设置导航条标题字体颜色为黑色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        // 修改每个 section 之间的间距：修改 section 的 footer 的大小
        tableView.sectionFooterHeight = 8
        
        // 设置多行文本在 label 中自动换行
        briefIntroLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        briefIntroLabel.numberOfLines = 0
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
        
        if indexPath.row == 0 {
            if let avatarNaviController = self.storyboard?.instantiateViewController(withIdentifier: "AvatarNaviController") as? UINavigationController {
                
                avatarNaviController.modalTransitionStyle = .coverVertical
                present(avatarNaviController, animated: true, completion: nil)
            }
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSetName" {
            let destination = segue.destination as! UINavigationController
            let setNameVC = destination.topViewController as! SetNameController
            setNameVC.name = self.nameLabel.text!
        }
        else if segue.identifier == "toSetGender" {
            let destination = segue.destination as! UINavigationController
            let setGenderVC = destination.topViewController as! SetGenderController
            setGenderVC.gender = self.genderLabel.text! == "女" ? "female" : "male"
        }
        else if segue.identifier == "toSetIntro" {
            let destination = segue.destination as! UINavigationController
            let setIntroVC = destination.topViewController as! SetIntroducationController
            setIntroVC.briefIntro = self.briefIntroLabel.text!
        }
    }

}
