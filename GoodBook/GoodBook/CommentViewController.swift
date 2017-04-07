//
//  CommentViewController.swift
//  GoodBook
//
//  Created by zhy on 17/4/7.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,InputViewDelegate {

    @IBOutlet weak var inputV: InputView!
    var BookObject : AVObject?
    var dataArray = NSMutableArray()
    var keyBoardHeight : CGFloat?
    
    
    @IBOutlet weak var tableV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableV.estimatedRowHeight = 300
        self.tableV.rowHeight = UITableViewAutomaticDimension
        self.tableV.register(CommentCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableV.mj_header = MJRefreshNormalHeader(refreshingBlock: { 
            
            
            let query = AVQuery(className: "comment")
            query.skip = 0
            query.order(byDescending: "createdAt")
            query.limit = 20
            query.whereKey("BookObject", equalTo: self.BookObject!)
            query.whereKey("User", equalTo: AVUser.current() as Any)
            
            //可以将表中的指针所对应的内容直接取过来
            query.includeKey("User")
            query.includeKey("BookObject")
            
            query.findObjectsInBackground({ (results, error) in
                
                self.tableV.mj_header.endRefreshing()
                if results != nil && (results as AnyObject).count != 0 {
                    self.dataArray.removeAllObjects()
                    self.dataArray.addObjects(from: results!)
                    self.tableV.reloadData()
                }
            })
            
        })
        
        self.tableV.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { 
            
            let query = AVQuery(className: "comment")
            query.skip = self.dataArray.count
            query.order(byDescending: "createdAt")
            query.limit = 20
            query.whereKey("BookObject", equalTo: self.BookObject!)
            query.whereKey("User", equalTo: AVUser.current() as Any)
            
            //可以将表中的指针所对应的内容直接取过来
            query.includeKey("User")
            query.includeKey("BookObject")
            
            query.findObjectsInBackground({ (results, error) in
                
                self.tableV.mj_footer.endRefreshing()
                if results != nil && (results as AnyObject).count != 0 {
                    self.dataArray.addObjects(from: results!)
                    self.tableV.reloadData()
                }
            })
        })
        
        self.tableV.mj_header.beginRefreshing()
        
        self.inputV!.textView.text = "fsdgdfsjhzdsfhs";
    }

    //UITableViewDelegate && UITablViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("CommentCell", owner: self, options: nil)?.last as? CommentCell
        
        let object = self.dataArray[indexPath.row] as? AVObject
        
        let user = object!["User"] as? AVUser
        cell?.naneLabel?.text = user?.username
        
        cell?.avatarImg?.image = UIImage(named: "Avatar")
        
        let date = object!["createdAt"] as? NSDate
        let format = DateFormatter()
        format.dateFormat = "YYYY-MM-dd hh:mm"
        cell?.dateLabel?.text = format.string(from: date! as Date)
        
        cell?.detailLabel?.text = object!["text"] as? String
        
        return cell!
        
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
            
            self.inputV?.bottom = SCREEN_HEIGHT
            
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
            object.setObject(self.BookObject, forKey: "BookObject")
            object.saveInBackground({ (success, error) in
                
                if success {
                    
                    self.inputV?.textView.resignFirstResponder()
                    self.inputV?.frame.size = CGSize(width: SCREEN_WIDTH, height: 44)
                    self.inputV?.textView.text = ""
                    ProgressHUD.showSuccess("评论成功")
                    
                    // 原子增加查看的次数
                    self.BookObject?.incrementKey("commentNumber")
                    // 保存时自动取回云端最新数据
                    self.BookObject?.fetchWhenSave = true;
                    self.BookObject?.saveInBackground()
                }else {
                    
                    ProgressHUD.showError("评论失败")
                }
            })
        }else {
            
            ProgressHUD.show("说点什么吧！！")
        }
    }
    
    
    @IBAction func colseAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }

}
