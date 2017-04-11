//
//  BookDetailController.swift
//  GoodBook
//
//  Created by zhy on 17/3/30.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

class BookDetailController: UIViewController,BookTabBarDelegate,InputViewDelegate {

    var bookObject : AVObject?
    var bookDetailView : BookDetailView2?
    var bookTabBar : BookTabBar?
    var bookTextView : UITextView?
    var inputV : InputView?
    var keyBoardHeight : CGFloat?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let manager = IQKeyboardManager.shared()
        manager.isEnabled = false
        
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
        self.bookTextView?.isUserInteractionEnabled = false
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
    
    //InputViewDelegate
    func keyBoardWillShow(_ view: InputView!, keyBoardH: CGFloat, animationDuration duration: TimeInterval, animationCurve: UIViewAnimationCurve) {
        
        self.keyBoardHeight = keyBoardH
        UIView.animate(withDuration: duration, delay: 0, options: .beginFromCurrentState, animations: {
            
            self.inputV?.bottom = SCREEN_HEIGHT - keyBoardH
            
        }) { (finish) in
        }
        
    }
    
    func keyBoardWillHide(_ view: InputView!, keyBoardH: CGFloat, animationDuration duration: TimeInterval, animationCurve: UIViewAnimationCurve) {
        
        UIView.animate(withDuration: duration, delay: 0, options: .beginFromCurrentState, animations: { 
            
            self.inputV?.bottom = SCREEN_HEIGHT + (self.inputV?.height)!
            
        }) { (finish) in
            
        }
    }
    
    func textViewHeightDidChange(_ height: CGFloat) {
        
        if height > (self.inputV?.height)! && (self.inputV?.height)! < 100 {
            self.inputV?.height = height+10
            self.inputV?.bottom = SCREEN_HEIGHT - self.keyBoardHeight!
        }
    }
    
    func releaseComment(_ comment: String!) {
        
        if comment != nil {
        
            let object = AVObject(className: "comment")
            object.setObject(comment, forKey: "text")
            object.setObject(AVUser.current(), forKey: "User")
            object.setObject(self.bookObject, forKey: "BookObject")
            object.saveInBackground({ (success, error) in
                
                if success {
                
                    self.inputV?.textView.resignFirstResponder()
                    self.inputV?.frame.size = CGSize(width: SCREEN_WIDTH, height: 44)
                    self.inputV?.textView.text = ""
                    ProgressHUD.showSuccess("评论成功")
                    
                    // 原子增加查看的次数
                    self.bookObject?.incrementKey("commentNumber")
                    // 保存时自动取回云端最新数据
                    self.bookObject?.fetchWhenSave = true;
                    self.bookObject?.saveInBackground()
                }else {
                
                    ProgressHUD.showError("评论失败")
                }
            })
        }else {
        
            ProgressHUD.show("说点什么吧！！")
        }
    }
    
    //BookTabBarDelegate
    func btnClick(tag: Int) {
        
        switch tag {
        case 0:
            
            print("comment")
            
            if self.inputV == nil {
                self.inputV = Bundle.main.loadNibNamed("InputView", owner: self, options: nil)?.last as? InputView
                self.inputV?.frame = CGRect(x: 0, y: SCREEN_HEIGHT-44, width: SCREEN_WIDTH, height: 44)
                self.inputV?.delegate = self;
                self.view.addSubview(self.inputV!)
            }
            self.inputV?.textView.becomeFirstResponder()
            break
        case 1:
            print("chat")
            
            let commentVC = CommentViewController()
            GeneralFactory.addTitleWithTitle(target: commentVC, title1: "", title2: "关闭")
            commentVC.BookObject = self.bookObject!
            self.present(commentVC, animated: true, completion: { 
                
            })
            
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.inputV?.textView.resignFirstResponder()
    }
    
}
