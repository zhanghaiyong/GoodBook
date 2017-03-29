//
//  photoPickerViewController.swift
//  GoodBook
//
//  Created by zhy on 17/3/23.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

protocol PhotoPickerDelegate {
    func getImageFromPicker(image : UIImage)
}

class photoPickerViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var alertCtrl : UIAlertController?
    var picker : UIImagePickerController?
    var delegate : PhotoPickerDelegate?
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
        
        //使背景变成透明的
        self.modalPresentationStyle = .overFullScreen
        
        self.view.backgroundColor = UIColor.clear
        
        self.picker = UIImagePickerController()
        self.picker?.allowsEditing = false
        self.picker?.delegate = self;
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.alertCtrl == nil {
            
            self.alertCtrl = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            self.alertCtrl?.addAction(UIAlertAction(title: "打开相机", style: .default, handler: { (UIAlertAction) in
                
                self.takePhoto()
                
            }))
            self.alertCtrl?.addAction(UIAlertAction(title: "从相册选择", style: .default, handler: { (UIAlertAction) in
                self.localPhoto()
            }))
            self.alertCtrl?.addAction(UIAlertAction(title: "取消", style: .destructive, handler: { (UIAlertAction) in
                
            }))
            
            self.present(self.alertCtrl!, animated: true, completion: {
                
            })
        }
    }
    
    //拍照
    func takePhoto() {
        
        //有照相机
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            //类型为相机
            self.picker?.sourceType = .camera
            self.present(self.picker!, animated: true, completion: {
                
            })
            
        }else {
        
            let alertView = UIAlertController(title: "此机型无相机", message: "", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "关闭", style: .default, handler: { (UIAlertAction) in
                self.dismiss(animated: true, completion: { 
                    
                })
            }))
            self.present(alertView, animated: true, completion: {
                
            })
        }
    }
    
    //取照片
    func localPhoto() {
     
        //类型为相册
        self.picker?.sourceType = .photoLibrary
        self.present(self.picker!, animated: true) {
            
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
  
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.picker?.dismiss(animated: true, completion: { 
            self.dismiss(animated: true, completion: { 
                self.delegate?.getImageFromPicker(image: image)
            })
        })
    }
    
    //取消
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.picker?.dismiss(animated: true, completion: {
            
            self.dismiss(animated: true, completion: {
                
            })
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    



}
