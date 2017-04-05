//
//  BookDetailController.swift
//  GoodBook
//
//  Created by zhy on 17/3/30.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

class BookDetailController: UIViewController,BookTabBarDelegate {

    var bookObject : AVObject?
    var bookDetailView : BookDetailView2?
    var bookTabBar : BookTabBar?
    var bookTextView : UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.bookDetailView = Bundle.main.loadNibNamed("BookDetailView2", owner: self, options: nil)?.last as? BookDetailView2
        self.bookDetailView?.frame = CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT/4)
        
        //封面
        let coverFile = self.bookObject!["Cover"] as? AVFile
        self.bookDetailView?.cover?.sd_setImage(with: URL.init(string: coverFile!.url!), placeholderImage: UIImage(named: "Cover"))
        
        //书名
        self.bookDetailView?.BookName?.text = "《" + (self.bookObject!["BookName"] as! String) + " 》"
        //作者
        self.bookDetailView?.Editor?.text = "作者:" + (self.bookObject!["BookEditor"] as! String)

        //用户数据
        let user = self.bookObject!["User"] as? AVUser
        user?.fetchInBackground({ (returuUser, error) in

            self.bookDetailView?.UserName?.text = "编者：" + (returuUser as! AVUser).username!
        })
        
        //日期
        let date = self.bookObject!["createdAt"] as! NSDate
        let format = DateFormatter()
        format.dateFormat = "YYYY-MM-dd"
        let dateStr = format.string(from: date as Date)
        self.bookDetailView?.Date?.text = dateStr
        
        //评分
        let scoreString = self.bookObject!["Score"] as? String
        self.bookDetailView?.score?.show_star = Int(scoreString!)!
        
        self.bookDetailView?.More?.text = "65个喜欢，5个评论，1200次浏览"
        
        self.view.addSubview(self.bookDetailView!)
        
        
        
        self.bookTabBar = Bundle.main.loadNibNamed("BookTabBar", owner: self, options: nil)?.last as? BookTabBar
        self.bookTabBar?.frame = CGRect(x: 0, y: SCREEN_HEIGHT-40, width: SCREEN_WIDTH, height: 40)
        self.bookTabBar?.delegate = self
        self.view.addSubview(self.bookTabBar!);
        
        self.bookTextView = UITextView(frame: CGRect(x: 0, y: 60+SCREEN_HEIGHT/4, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64-40-SCREEN_HEIGHT/4))
        self.bookTextView?.isEditable = false
        self.bookTextView?.font = UIFont(name: MY_FONT, size: 15)
        self.bookTextView?.text = self.bookObject!["Description"] as? String
        self.view.addSubview(self.bookTextView!)
        
        self.isCollect()
    }
    
    
    //是否已经点赞
    func isCollect() {
        let query = AVQuery(className: "collect")
        query.whereKey("User", equalTo: AVUser.current() as Any)
        query.whereKey("BookObject", equalTo: self.bookObject as Any)
        query.findObjectsInBackground { (results, error) in
            
            if results != nil && (results as AnyObject).count != 0 {
            
                self.bookTabBar?.collectBtn.setImage(UIImage(named:"solidheart"), for: .normal)
            }
        }
    }
    
    //BookTabBarDelegate
    func btnClick(tag: Int) {
        
        switch tag {
        case 0:
            
            print("comment")
            
            break
        case 1:
            print("chat")
            break
        case 2:
            print("collect")
            
            //避免重复操作
            self.bookTabBar?.collectBtn.isUserInteractionEnabled = false
            //设置按钮图片
            self.bookTabBar?.collectBtn.setImage(UIImage(named:"redheart"), for: .normal)
            
            //查询点赞
            let query = AVQuery(className: "collect")
            query.whereKey("User", equalTo: AVUser.current() as Any)
            query.whereKey("BookObject", equalTo: self.bookObject as Any)
            query.findObjectsInBackground { (results, error) in
                
                //已经点赞
                if results != nil && (results as AnyObject).count != 0 {
                  
                    //移除点赞信息
                    for var object in (results as AnyObject) as! NSArray {
                    
                        object = (object as? AVObject)! as AVObject
                        (object as AnyObject).deleteEventually()
                    }
                    //设置按钮图片
                    self.bookTabBar?.collectBtn.setImage(UIImage(named:"heart"), for: .normal)
                    
                }else { //没有点赞
                
                    let object = AVObject(className: "collect")
                    object.setObject(AVUser.current(), forKey: "User")
                    object.setObject(self.bookObject, forKey: "BookObject")
                    object.saveInBackground({ (success, error) in
                        
                        if success {
                            //设置按钮图片
                            self.bookTabBar?.collectBtn.setImage(UIImage(named:"solidheart"), for: .normal)
                        }else {
                        
                            ProgressHUD.showError("收藏失败")
                        }
                    })
                }
                
                self.bookTabBar?.collectBtn.isUserInteractionEnabled = true
            }
            
            break
        case 3:
            print("share")
            break
        default:
            break
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
