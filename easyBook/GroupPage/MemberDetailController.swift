//
//  MemberDetailController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/22.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class MemberDetailController: UIViewController {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var avatarImageView: CustomImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var actionBtn: UIButton!
    
    var memberInfo: Member!
    var btnType = "remove"
    var showBtn = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置返回按钮颜色
        navigationController?.navigationBar.tintColor = UIColor.white
        
        actionBtn.isHidden = !showBtn
        btnType == "remove" ? actionBtn.setTitle("移除该成员", for: .normal) : actionBtn.setTitle("发送邀请", for: .normal)
        bgImageView.image = UIImage(named: memberInfo.personBg)
        avatarImageView.image = UIImage(named: memberInfo.avatar)
        nameLabel.text = memberInfo.name
        genderImageView.image = memberInfo.gender == "female" ? UIImage(named: "female_15x15_") : UIImage(named: "male_15x15_")
        phoneLabel.text = memberInfo.phone
        introductionLabel.text = memberInfo.introducation
        
        // 设置多行文本在 label 中自动换行
        introductionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        introductionLabel.numberOfLines = 0
    }
    
    // 设置状态栏字体颜色为白色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = UIColor(named: "themeDarkBlack")
        // 去掉返回按钮后的文字
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
    // MARK: - Event Listeners
    
    @IBAction func tapActionBtn(_ sender: UIButton) {
        if btnType == "remove" {
            // TODO
        } else {
            if let sendMessageVC = self.storyboard?.instantiateViewController(withIdentifier: "SendMessageController") as? SendMessageController {
                self.navigationController?.pushViewController(sendMessageVC, animated: true)
            }
        }
    }
    
}
