//
//  BookDetailController.swift
//  GoodBook
//
//  Created by zhy on 17/3/30.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

class BookDetailController: UIViewController {

    var bookObject : AVObject?
    var bookDetailView : BookDetailView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.bookDetailView = BookDetailView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT/4))
        
        let coverFile = self.bookObject!["Cover"] as? AVFile
        self.bookDetailView?.cover?.sd_setImage(with: URL.init(string: coverFile!.url!), placeholderImage: UIImage(named: "Cover"))
        
        self.bookDetailView?.BookName?.text = "《" + (self.bookObject!["BookName"] as! String) + " 》"
        self.bookDetailView?.Editor?.text = "作者:" + (self.bookObject!["BookEditor"] as! String)
        
        let user = self.bookObject!["User"] as? AVUser
        user?.fetchInBackground({ (returuUser, error) in
            
            self.bookDetailView?.UserName?.text = "编者：" + (returuUser as! AVUser).username!
        })
        
        let date = self.bookObject!["createdAt"] as! NSDate
        let format = DateFormatter()
        format.dateFormat = "YYYY-MM-dd"
        let dateStr = format.string(from: date as Date)
        self.bookDetailView?.Date?.text = dateStr
        
        
        let scoreString = self.bookObject!["Score"] as? String
        self.bookDetailView?.score?.show_star = Int(scoreString!)!
        
        self.bookDetailView?.More?.text = "65个喜欢，5个评论，1200次浏览"
        
        self.view.addSubview(self.bookDetailView!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
