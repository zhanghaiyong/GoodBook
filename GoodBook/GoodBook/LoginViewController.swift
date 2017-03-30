//
//  LoginViewController.swift
//  GoodBook
//
//  Created by zhy on 17/3/29.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var pwd: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //登录
    @IBAction func loginAction(_ sender: Any) {
        
        AVUser.logInWithUsername(inBackground: self.userName.text!, password: self.pwd.text!) { (success, error) in
            
            if (success != nil) {
            
                ProgressHUD.showSuccess("登录成功")
                self.dismiss(animated: true, completion: nil)
            }else {
            
                ProgressHUD.showSuccess("登录失败")
            }
        }
    }
}
