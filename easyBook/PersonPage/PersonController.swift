//
//  PersonController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/1/20.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class PersonController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 修改每个section之间的间距：修改section的footer的大小
        tableView.sectionFooterHeight = 8
    }

    /// 在视图加载完毕后取消第一个section的点击效果,
    /// 若在viewDidLoad()中写，则还未加载到第一个section，会报空指针
    ///
    /// - Parameter animated: Bool
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.cellForRow(at: [0, 0])?.selectionStyle = .none
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 定制关于作者页面返回按钮上无文字
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    /// 修改每个section之间的间距：修改section的header的大小
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消点击行则选中的状态
        tableView.deselectRow(at: indexPath, animated: true)
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
