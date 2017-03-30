//
//  RegisterViewController.swift
//  GoodBook
//
//  Created by zhy on 17/3/29.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func registerAction(_ sender: Any) {
        let user = AVUser()
        user.username = self.userName.text
        user.password = self.pwd.text
        user.email = self.email.text
        
        user.signUpInBackground { (success, error) in
            if success {
            
                ProgressHUD.showSuccess("注册成功")
                self.dismiss(animated: true, completion: { 
                    
                })
            }else {
                
                if (error as! NSError).code == 125 {
                    ProgressHUD.showError("邮箱不合法")
                }else if (error as! NSError).code == 203 {
                
                    ProgressHUD.showError("该邮箱已注册")
                }else if (error as! NSError).code == 202 {
                    
                    ProgressHUD.showError("用户名已存在")
                }else {
                    
                    ProgressHUD.showError("注册失败")
                }
            }
        }
    
    }
    
    @IBAction func closeAction(_ sender: Any) {
        
        self.dismiss(animated: true) { 
            
        }
    }

}
