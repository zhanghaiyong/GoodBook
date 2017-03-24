//
//  pushViewController.swift
//  GoodBook
//
//  Created by zhy on 17/3/23.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

class pushViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.backgroundColor = UIColor.white
        self.setNavigationBar()
        
    }

    func setNavigationBar() {
        
        let navigationView = UIView(frame: CGRect(x: 0, y: -20, width: SCREEN_WIDTH, height: 65))
        navigationView.backgroundColor = UIColor.white
        
        self.navigationController?.navigationBar.addSubview(navigationView)
        
        let addBookBtn = UIButton(frame: CGRect(x: 20, y: 20, width: SCREEN_WIDTH, height: 45))
        addBookBtn.setImage(UIImage.init(named: "plus circle"), for: .normal)
        addBookBtn.setTitleColor(UIColor.black, for: .normal)
        addBookBtn.setTitle("    新建标题", for: .normal)
        addBookBtn.titleLabel?.font = UIFont(name: MY_FONT, size: 15)
        addBookBtn.contentHorizontalAlignment = .left
        addBookBtn .addTarget(self, action: #selector(pushViewController.pushNewBook), for: .touchUpInside)
        navigationView.addSubview(addBookBtn)
    }
    
    func pushNewBook() {
        
        let vc = pushNewBookController()
        GeneralFactory.addTitleWithTitle(target: vc, title1: "关闭", title2:"发布")
        self.present(vc, animated: true) { }
        
    }

}
