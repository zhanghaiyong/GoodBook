//
//  BookTitleView.swift
//  GoodBook
//
//  Created by zhy on 17/3/23.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit


//OC协议
@objc protocol bookTitleDelegate {

    //可选
    @objc optional func choiceCover()
}

class BookTitleView: UIView {

    //可选变量 封面
    var BookCover : UIButton?
    //书名
    var BookName :  JVFloatLabeledTextField?
    //作者
    var BookEditor :  JVFloatLabeledTextField?
    
    weak var delegate : bookTitleDelegate?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.BookCover = UIButton(frame: CGRect(x: 10, y: 0, width: 110, height: 141))
        self.BookCover?.setImage(UIImage.init(named: "Cover"), for: .normal)
        self.addSubview(self.BookCover!) //解包
        self.BookCover?.addTarget(self, action: #selector(BookTitleView.choiceCoverAction), for: .touchUpInside)
        
        
        self.BookName = JVFloatLabeledTextField(frame: CGRect(x: 128, y: 8+40, width: SCREEN_WIDTH-128-15, height: 30))
        self.BookEditor = JVFloatLabeledTextField(frame: CGRect(x: 128, y: 8+70+40, width: SCREEN_WIDTH-128-15, height: 30))
        
        
        self.BookName?.placeholder = "书名"
        self.BookEditor?.placeholder = "作者"

        self.BookName?.floatingLabelFont = UIFont(name: MY_FONT, size: 14)
        self.BookEditor?.floatingLabelFont = UIFont(name: MY_FONT, size: 14)
        
        self.BookName?.font = UIFont(name: MY_FONT, size: 14)
        self.BookEditor?.font = UIFont(name: MY_FONT, size: 14)
        
        self.addSubview(self.BookName!)
        self.addSubview(self.BookEditor!)
        
    }
    
    func choiceCoverAction() {
        
        self.delegate?.choiceCover!()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
