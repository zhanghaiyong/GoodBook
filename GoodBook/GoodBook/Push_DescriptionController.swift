//
//  Push_DescriptionController.swift
//  GoodBook
//
//  Created by zhy on 17/3/24.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

typealias Push_DescriptionBlock = (_ description : String) -> Void

class Push_DescriptionController: BaseViewController {

    var textView : JVFloatLabeledTextView?
    
    var callBack : Push_DescriptionBlock?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.textView = JVFloatLabeledTextView(frame: CGRect(x: 8, y: 58, width: SCREEN_WIDTH-16, height: SCREEN_HEIGHT-60))
        self.view.addSubview(self.textView!)
        self.textView?.placeholder = "     你可以在这里撰写详细的评价、吐槽、介绍~ ~"
        self.textView?.font = UIFont(name: MY_FONT, size: 17)
        self.view.tintColor = UIColor.gray
        self.textView?.becomeFirstResponder()
    }

    //关闭
    func closeAction() {
        
        self.dismiss(animated: true) {
            
        }
    }
    
    //发布
    func sureAction() {
        
        self.callBack!((self.textView?.text)!)
        self.dismiss(animated: true) {
            
        }
    }
}
