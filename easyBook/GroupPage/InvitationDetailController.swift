//
//  InvitationDetailController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/23.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class InvitationDetailController: UIViewController {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var avatarImageView: CustomImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var memberInfo: Member!
    var message: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置返回按钮颜色
        navigationController?.navigationBar.tintColor = UIColor.white
        
        bgImageView.image = UIImage(named: memberInfo.personBg)
        avatarImageView.image = UIImage(named: memberInfo.avatar)
        nameLabel.text = memberInfo.name
        genderImageView.image = memberInfo.gender == "female" ? UIImage(named: "female_15x15_") : UIImage(named: "male_15x15_")
        introductionLabel.text = memberInfo.introducation
        messageLabel.text = message
        
        // 设置多行文本在 label 中自动换行
        introductionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        introductionLabel.numberOfLines = 0
        messageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        messageLabel.numberOfLines = 0
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
    }
    
    
    // MARK: - Event Listeners
    
    @IBAction func tapApproveBtn(_ sender: UIButton) {
        // TODO
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
