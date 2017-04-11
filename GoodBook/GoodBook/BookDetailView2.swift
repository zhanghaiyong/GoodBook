//
//  BookDetailView2.swift
//  GoodBook
//
//  Created by zhy on 17/3/31.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit


protocol BookDetailViewDelegate {
    
    func BrowserBigCover()
}

class BookDetailView2: UIView {

    @IBOutlet weak var BookName: UILabel!
    @IBOutlet weak var Editor: UILabel!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var score: LDXScore!
    @IBOutlet weak var More: UILabel!
    @IBOutlet weak var cover: UIImageView!
    
    var delegate : BookDetailViewDelegate?
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(BookDetailView2.tapImageAction))
        self.cover.addGestureRecognizer(tap)
    }
    
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(0.5)
        context?.setStrokeColor(UIColor.gray.cgColor)
        context?.move(to: CGPoint(x: 8, y: self.frame.size.height-2))
        context?.addLine(to: CGPoint(x: self.frame.size.width-8, y: self.frame.size.height-2))
        context?.strokePath()
    }
    
    func tapImageAction() {
        
        self.delegate?.BrowserBigCover()
    }

}
