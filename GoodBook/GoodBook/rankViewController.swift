//
//  rankViewController.swift
//  GoodBook
//
//  Created by zhy on 17/3/23.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

class rankViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        if AVUser.current() == nil { //未登录
        let sb = UIStoryboard(name: "Login", bundle: nil)
            let loginVC = sb.instantiateViewController(withIdentifier: "Login")
            self.present(loginVC, animated: true, completion: { 
                
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
