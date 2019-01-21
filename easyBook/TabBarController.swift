//
//  TabBarController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/1/20.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 修改选中的 tab bar 的图片
        var tabBarItems: [UITabBarItem] = self.tabBar.items!
        tabBarItems[0].selectedImage = UIImage(named: "tabBar_calendar_active_26x26_")
        tabBarItems[1].selectedImage = UIImage(named: "tabBar_group_active_26x26_")
        tabBarItems[2].selectedImage = UIImage(named: "tabBar_discover_active_26x26_")
        tabBarItems[3].selectedImage = UIImage(named: "tabBar_me_active_26x26_")
        // 将 tab bar 的文字向上调整2个单位
        for tabBarItem in tabBarItems {
            tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
            tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 10)!], for: .normal)
        }
        // 设置 tab bar 选中时字体颜色
        self.tabBar.tintColor = UIColor(named: "themeColor")
        // 设置 tab bar 未选中时字体颜色
        self.tabBar.unselectedItemTintColor = UIColor(named: "themeGray")
    }

}
