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
    @IBOutlet weak var removeBtn: UIButton!
    
    var memberInfo: Member!
    var showRemoveBtn = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置返回按钮颜色
        navigationController?.navigationBar.tintColor = UIColor.white
        
        removeBtn.isHidden = !showRemoveBtn
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = UIColor(named: "themeDarkBlack")
    }
    
}
