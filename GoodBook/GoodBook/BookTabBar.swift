//
//  BookTabBar.swift
//  GoodBook
//
//  Created by zhy on 17/4/1.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

protocol BookTabBarDelegate {
    
    func btnClick(tag : Int)
}

class BookTabBar: UIView {

    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var collectBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    var delegate : BookTabBarDelegate?
    
    override func draw(_ rect: CGRect) {
        
        let content = UIGraphicsGetCurrentContext()
        content?.setLineWidth(0.5)
        content?.setStrokeColor(UIColor.gray.cgColor)
        
        var i : Int = 0
        for _ in 0  ..< 4  {
        
            content?.move(to: CGPoint(x: rect.size.width/4 + CGFloat(i) * rect.size.width/4, y: rect.size.height*0.1))
            content?.addLine(to: CGPoint(x: rect.size.width/4 + CGFloat(i) * rect.size.width/4, y: rect.size.height*0.9))
            content?.strokePath()
            i += 1
        }
        
        content?.move(to: CGPoint(x: 8, y: 0))
        content?.addLine(to: CGPoint(x: rect.size.width-8, y: 0))
        content?.strokePath()
    }

    @IBAction func commentAction(_ sender: Any) {
        
        self.delegate?.btnClick(tag: 0)
    }
    
    @IBAction func chatAction(_ sender: Any) {
        
        self.delegate?.btnClick(tag: 1)
    }
    
    @IBAction func collectAction(_ sender: Any) {
        
        let btn = sender as! UIButton
        
        
        
        
        
        self.delegate?.btnClick(tag: 2)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        self.delegate?.btnClick(tag: 3)
    }
}
