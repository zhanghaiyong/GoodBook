//
//  Push_TypeController.swift
//  GoodBook
//
//  Created by zhy on 17/3/24.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

class Push_TypeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //关闭
    func closeAction() {
        
        self.dismiss(animated: true) {
            
        }
    }
    
    //发布
    func sureAction() {
        
    }

}
