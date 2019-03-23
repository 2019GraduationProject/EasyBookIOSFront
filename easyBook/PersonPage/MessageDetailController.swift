//
//  MessageDetailController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/19.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class MessageDetailController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    var naviBarShadowImage = UIImage(named: "separator") // 存储导航条图片
    var message: Message!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "消息详情"
        // 设置导航条标题字体颜色为黑色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        
        navigationController?.navigationBar.shadowImage = naviBarShadowImage
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        
        // 设置多行文本在 label 中自动换行
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.numberOfLines = 0
        
        titleLabel.text = message.title
        timeLabel.text = message.time
        contentTextView.text = message.content
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
}
