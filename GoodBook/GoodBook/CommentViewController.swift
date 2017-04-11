//
//  CommentViewController.swift
//  GoodBook
//
//  Created by zhy on 17/4/7.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,InputViewDelegate {

    var BookObject : AVObject?
    var dataArray = NSMutableArray()
    var keyBoardHeight : CGFloat?
    
    var tableV: UITableView!
    var input : InputView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        label.text = "评论区"
        label.font = UIFont(name: MY_FONT, size: 16)
        label.textColor = MAIN_RED
        label.textAlignment = .center
        self.view.addSubview(label)
        
        self.tableV = UITableView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64-44))
        self.tableV.delegate = self;
        self.tableV.dataSource = self;
        self.tableV.estimatedRowHeight = 300
        self.tableV.rowHeight = UITableViewAutomaticDimension
        self.tableV.register(CommentCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableV!)
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
        
        self.input = Bundle.main.loadNibNamed("InputView", owner: self, options: nil)?.last as? InputView
        self.input?.frame = CGRect(x: 0, y: SCREEN_HEIGHT-44, width: SCREEN_WIDTH, height: 44)
        self.input?.delegate = self;
        self.view.addSubview(self.input!)
        
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
            
            self.input?.bottom = SCREEN_HEIGHT - keyBoardH
            
        }) { (finish) in
        }
        
    }
    
    func keyBoardWillHide(_ view: InputView!, keyBoardH: CGFloat, animationDuration duration: TimeInterval, animationCurve: UIViewAnimationCurve) {
        
        UIView.animate(withDuration: duration, delay: 0, options: .beginFromCurrentState, animations: {
            
            self.input?.bottom = SCREEN_HEIGHT
            
        }) { (finish) in
            
        }
    }
    
    func textViewHeightDidChange(_ height: CGFloat) {
        
        if height > (self.input?.height)! && (self.input?.height)! < 100 {
            self.input?.height = height+10
            self.input?.bottom = SCREEN_HEIGHT - self.keyBoardHeight!
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
                    
                    self.input?.textView.resignFirstResponder()
                    self.input?.frame = CGRect(x: 0, y: SCREEN_HEIGHT-44, width: SCREEN_WIDTH, height: 44)
                    self.input?.textView.text = ""
                    ProgressHUD.showSuccess("评论成功")
                    
                    // 原子增加查看的次数
                    self.BookObject?.incrementKey("commentNumber")
                    self.dataArray.add(object)
                    self.tableV.reloadData()
                    
                    let index = NSIndexPath(row: self.dataArray.count-1, section: 0)
                    self.tableV.scrollToRow(at: index as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
                    
                    
                }else {
                    
                    ProgressHUD.showError("评论失败")
                }
            })
        }else {
            
            ProgressHUD.show("说点什么吧！！")
        }
    }
    
    func closeAction() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func sureAction() {
        
        self.dismiss(animated: true, completion: nil)
    }

}
