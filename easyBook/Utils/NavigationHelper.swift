//
//  NavigationHelper.swift
//  easyBook
//
//  Created by 黄小白 on 2019/1/21.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    // 导航条状态栏的颜色由最上层子页面决定
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
}
