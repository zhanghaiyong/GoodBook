//
//  rankViewController.swift
//  GoodBook
//
//  Created by zhy on 17/3/23.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

class rankViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        label.center = self.view.center
        label.textAlignment = NSTextAlignment.center
        label.adjustsFontSizeToFitWidth = true
        //label.font = UIFont(name: "Bauhaus ITC", size: 13)
        label.text = "测试"
        label.textColor = UIColor.black
        self.view.addSubview(label)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
