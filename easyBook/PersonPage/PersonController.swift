//
//  PersonController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/1/20.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit

class PersonController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userBgImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置导航条背景透明
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        // 设置导航条标题字体颜色为白色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        // 设置返回按钮颜色
        navigationController?.navigationBar.tintColor = UIColor(named: "themeDarkBlack")
    }
    
    // 设置状态栏字体颜色为白色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// 取消第一个 section 的点击效果
    /// ⚠️注：若在viewDidLoad()中写，则还未加载到第一个section，会报空指针
    ///
    /// - Parameter animated: Bool
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.cellForRow(at: [0, 0])?.selectionStyle = .none
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 定制返回按钮上无文字
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消点击行则选中的状态
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        userBgImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        // 关闭相册
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Event Listeners
    
    @IBAction func tapBgImageView(_ sender: UITapGestureRecognizer) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let choosePhotoAction = UIAlertAction(title: "更换背景图片", style: .default) { (_) in
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                return
            }
            
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        choosePhotoAction.setValue(UIColor.darkText, forKey: "titleTextColor")
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        cancelAction.setValue(UIColor(named: "themeColor"), forKey: "titleTextColor")
        
        actionSheet.addAction(choosePhotoAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
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
