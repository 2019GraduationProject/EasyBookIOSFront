//
//  AvatarController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/16.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit
import Photos
import FTIndicator

class AvatarController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationItem.title = "个人头像"
//        // 设置导航条标题字体颜色为白色
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        // 设置返回按钮颜色
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 设置返回按钮颜色
        navigationController?.navigationBar.tintColor = UIColor(named: "themeDarkBlack")
    }
    
    // 设置状态栏字体颜色为白色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        avatarImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        // 关闭相册
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Event Listeners
    
    @IBAction func tapMoreButton(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let takePhotoAction = UIAlertAction(title: "拍照", style: .default) { (_) in
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                return
            }
            
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        takePhotoAction.setValue(UIColor.darkText, forKey: "titleTextColor")
        
        let choosePhotoAction = UIAlertAction(title: "从手机相册选择", style: .default) { (_) in
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                return
            }
            
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        choosePhotoAction.setValue(UIColor.darkText, forKey: "titleTextColor")
        
        let savePhotoAction = UIAlertAction(title: "保存图片", style: .default) { (_) in
            guard UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) else {
                return
            }
            // 获取头像图片
            let image = self.avatarImageView.image!
            // 保存到系统相册
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            }, completionHandler: { (isSuccess: Bool, error: Error?) in
                FTIndicator.setIndicatorStyle(.dark)
                if isSuccess {
                    FTIndicator.showSuccess(withMessage: "已保存到系统相册")
                } else {
                    FTIndicator.showInfo(withMessage: "保存失败")
                }
            })
        }
        savePhotoAction.setValue(UIColor.darkText, forKey: "titleTextColor")
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        cancelAction.setValue(UIColor(named: "themeColor"), forKey: "titleTextColor")
        
        actionSheet.addAction(takePhotoAction)
        actionSheet.addAction(choosePhotoAction)
        actionSheet.addAction(savePhotoAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }

}
