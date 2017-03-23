//
//  photoPickerViewController.swift
//  GoodBook
//
//  Created by zhy on 17/3/23.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

class photoPickerViewController: UIViewController,UIImagePickerControllerDelegate {

    let alertCtrl : UIAlertController?
    let picker : UIImagePickerController?
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
        
        //使背景变成透明的
        self.modalPresentationStyle = .overFullScreen
        
        self.view.backgroundColor = UIColor.clear
        
        self.picker = UIImagePickerController()
        self.picker?.allowsEditing = false
        self.picker?.delegate = self;
        
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
