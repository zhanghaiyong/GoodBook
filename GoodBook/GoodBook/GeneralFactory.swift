//
//  GeneralFactory.swift
//  GoodBook
//
//  Created by zhy on 17/3/23.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

class GeneralFactory: NSObject {

    
    //有默认参数的静态函数
    static func addTitleWithTitle(target:UIViewController,title1:String = "关闭" , title2 :String = "确认") {
    
        let Btn1 = UIButton(frame: CGRect(x: 10, y: 20, width: 40, height: 20))
        Btn1.setTitle(title1, for: .normal)
        Btn1.contentHorizontalAlignment = .left
        Btn1.setTitleColor(MAIN_RED, for: .normal)
        Btn1.titleLabel?.font = UIFont(name: MY_FONT, size: 14)
        target.view.addSubview(Btn1)
        
        let Btn2 = UIButton(frame: CGRect(x: SCREEN_WIDTH-50, y: 20, width: 40, height: 20))
        Btn2.setTitle(title2, for: .normal)
        Btn2.contentHorizontalAlignment = .right
        Btn2.setTitleColor(MAIN_RED, for: .normal)
        Btn2.titleLabel?.font = UIFont(name: MY_FONT, size: 14)
        target.view.addSubview(Btn2)
        
        Btn1.addTarget(target, action: Selector(("closeAction")), for: .touchUpInside)
        Btn2.addTarget(target, action: Selector(("sureAction")), for: .touchUpInside)
    }
    
}
