//
//  EventDetailController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/11.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class EventDetailController: UITableViewController {
    
    var groupNum: Int! // 群组数量
    var clauseNum: Int! // 条目数量

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.sectionFooterHeight = 0
        
        // 创建重用的单元格
        self.tableView.register(UINib(nibName: "DetailGroupCell", bundle: nil), forCellReuseIdentifier: "DetailGroupCell")
        self.tableView.register(UINib(nibName: "DetailClauseCell", bundle: nil), forCellReuseIdentifier: "DetailClauseCell")
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return groupNum
        } else if section == 2 {
            return clauseNum
        } else {
            return super.tableView(self.tableView, numberOfRowsInSection: section)
        }
    }
    
    /// 修改每个section之间的间距：修改section的header的大小
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    // MARK: - Event Listeners

    @IBAction func tapBackButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
