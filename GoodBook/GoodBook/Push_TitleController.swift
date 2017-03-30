//
//  Push_TitleController.swift
//  GoodBook
//
//  Created by zhy on 17/3/24.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

//1 声明block
typealias Push_TitleCallBack = (_ title:String) ->Void

class Push_TitleController: BaseViewController {

    var textField :UITextField?
    
    
    //实现回调
    //block
    //delegate
    //通知
    
    //2 定义block
    var callBack : Push_TitleCallBack?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        
        self.textField = UITextField(frame: CGRect(x: 15, y: 60, width: SCREEN_WIDTH-30, height: 30))
        self.textField?.borderStyle = .roundedRect
        self.textField?.placeholder = "书评标题"
        self.textField?.font = UIFont(name: MY_FONT, size: 15)
        self.view.addSubview(self.textField!)
        
        self.textField?.becomeFirstResponder()
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
     
        //3 调用block
        self.callBack!((self.textField?.text)!)
        self.closeAction()
        
    }

}
