//
//  BookDetailView.swift
//  GoodBook
//
//  Created by zhy on 17/3/30.
//  Copyright © VIEW_HEIGHT/617年 zhanghaiyong. All rights reserved.
//

import UIKit

class BookDetailView: UIView {

    var VIEW_WIDTH : CGFloat?
    var VIEW_HEIGHT : CGFloat?
    
    
    var BookName : UILabel?
    var Editor : UILabel?
    var UserName : UILabel?
    var Date : UILabel?
    var More : UILabel?
    var score : LDXScore?
    var cover : UIImageView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.VIEW_WIDTH = frame.size.width
        self.VIEW_HEIGHT = frame.size.height
        self.backgroundColor = UIColor.white
        
        
        self.cover = UIImageView(frame: CGRect(x: 8, y: 8, width: (VIEW_HEIGHT!-16)*3/4, height: VIEW_HEIGHT!-16))
        self.addSubview(self.cover!)
        
        self.BookName = UILabel(frame: CGRect(x: VIEW_HEIGHT!*3/4, y: 0, width: VIEW_WIDTH!, height: VIEW_HEIGHT!/6))
        self.BookName?.font = UIFont(name: MY_FONT, size: 18)
        self.addSubview(self.BookName!)
        
        
        self.Editor = UILabel(frame: CGRect(x: VIEW_HEIGHT!*3/4, y: VIEW_HEIGHT!/6, width: VIEW_WIDTH!, height: VIEW_HEIGHT!/6))
        self.Editor?.font = UIFont(name: MY_FONT, size: 18)
        self.addSubview(self.Editor!)
        
        self.UserName = UILabel(frame: CGRect(x: VIEW_HEIGHT!*3/4, y: VIEW_HEIGHT!/6*2, width: VIEW_WIDTH!, height: VIEW_HEIGHT!/6))
        self.Editor?.textColor = RGB(r: 35, g: 87, b: 139)
        self.UserName?.font = UIFont(name: MY_FONT, size: 13)
        self.addSubview(self.UserName!)
        
        self.Date = UILabel(frame: CGRect(x: VIEW_HEIGHT!*3/4, y: VIEW_HEIGHT!/6*3, width: VIEW_WIDTH!, height: VIEW_HEIGHT!/6))
        self.Date?.textColor = UIColor.gray
        self.Date?.font = UIFont(name: MY_FONT, size: 13)
        self.addSubview(self.Date!)
        
        self.score = LDXScore(frame: CGRect(x: VIEW_HEIGHT!*3/4, y: VIEW_HEIGHT!/6*4, width: VIEW_WIDTH!, height: VIEW_HEIGHT!/6))
        self.score?.isSelect = false
        self.score?.normalImg = UIImage(named: "btn_star_evaluation_normal")
        self.score?.highlightImg = UIImage(named: "btn_star_evaluation_press")
        self.score?.max_star = 5
        self.score?.show_star = 5
        self.addSubview(self.score!)
        
        self.More = UILabel(frame: CGRect(x: VIEW_HEIGHT!*3/4, y: VIEW_HEIGHT!/6*5, width: VIEW_WIDTH!, height: VIEW_HEIGHT!/6))
        self.More?.textColor = UIColor.gray
        self.More?.font = UIFont(name: MY_FONT, size: 13)
        self.addSubview(self.More!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(0.5)
        context?.setFillColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1)
        context?.move(to: CGPoint(x: 8, y: VIEW_HEIGHT!-2))
        context?.addLine(to: CGPoint(x: VIEW_WIDTH!-8, y: VIEW_HEIGHT!-2))
        context?.strokePath()
        
    }

}
