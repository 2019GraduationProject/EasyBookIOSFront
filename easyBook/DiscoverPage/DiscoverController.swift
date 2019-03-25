//
//  DiscoverController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/9.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit
import SwipeMenuViewController

class DiscoverController: SwipeMenuViewController {

    private var tabTitles: [String] = ["组内/跨组事件", "全局事件"]
    var tabCount: Int = 2
    
    
    override func viewDidLoad() {
        let localDiscoverVC = self.storyboard?.instantiateViewController(withIdentifier: "LocalDiscoverController") as! LocalDiscoverController
        let globalDiscoverVC = self.storyboard?.instantiateViewController(withIdentifier: "GlobalDiscoverController") as! GlobalDiscoverController
        self.addChild(localDiscoverVC)
        self.addChild(globalDiscoverVC)
        
        super.viewDidLoad()
    }
    
    /// 定制 SwipeMenuView 的外观
    /// ⚠️注：若在viewDidLoad()中写，self.swipeMenuView 会报空指针
    ///
    /// - Parameter animated: Bool
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var options = SwipeMenuViewOptions()
        options.tabView.style = .segmented
        options.tabView.backgroundColor = UIColor(named: "themeColor")!
//        options.tabView.addition = .none
        options.tabView.itemView.selectedTextColor = UIColor.white
        options.tabView.additionView.backgroundColor = UIColor.white
        options.tabView.additionView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 1.5, right: 0)
        self.swipeMenuView.reloadData(options: options)
    }
    
    
    // MARK - SwipeMenuViewDataSource
    
    override func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return tabCount
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return tabTitles[index]
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        let vc = children[index]
        vc.didMove(toParent: self)
        return vc
    }
    
}
