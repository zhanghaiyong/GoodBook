//
//  pushViewController.swift
//  GoodBook
//
//  Created by zhy on 17/3/23.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

class pushViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var dataArray = NSMutableArray()
    var tableView : UITableView?
    var navigationView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.setNavigationBar()
        
        self.tableView = UITableView(frame: self.view.bounds)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.tableFooterView = UIView()
        self.tableView?.register(PushBook_Cell.classForCoder(), forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
        
        //下拉刷新
        self.tableView?.mj_header = MJRefreshNormalHeader(refreshingBlock: { 
          
            let query = AVQuery(className: "Book")
            query.order(byAscending: "createdAt")
            //一次加载20
            query.limit = 20
            //跳过多少个
            query.skip = 0
            query.whereKey("User", equalTo: AVUser.current() as Any)
            query.findObjectsInBackground({ (results, error) in
                
                self.tableView?.mj_header.endRefreshing()
                self.dataArray.removeAllObjects()
                self.dataArray.addObjects(from: results!)
                self.tableView?.reloadData()
            })
        })
        
        //上拉加载
        self.tableView?.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            
            let query = AVQuery(className: "Book")
            query.order(byAscending: "createdAt")
            //一次加载20
            query.limit = 20
            //跳过多少个
            query.skip = self.dataArray.count
            //限制---查询自己发布的
            query.whereKey("User", equalTo: AVUser.current() as Any)
            query.findObjectsInBackground({ (results, error) in
                
                self.tableView?.mj_footer.endRefreshing()
                self.dataArray.addObjects(from: results!)
                self.tableView?.reloadData()
                
            })
            
        })
        
        self.tableView?.mj_header.beginRefreshing()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationView?.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationView?.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    //UITableViewDelegate && UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView?.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PushBook_Cell
        
        let dict = self.dataArray[indexPath.row] as? AVObject
        
        cell?.BookName?.text = "《" + (dict?["BookName"] as? String)! + " 》" + (dict!["Title"] as? String)!
        cell?.Editor?.text = "作者：" + (dict!["BookEditor"] as? String)!
        
        let date = dict!["createdAt"] as? NSDate
        let format = DateFormatter()
        format.dateFormat = "YYYY-MM-dd hh:mm"
        let dateStr = format.string(from: date! as Date)
        cell?.More?.text = dateStr
        
        let avFile = dict!["Cover"] as? AVFile
        cell?.Cover?.sd_setImage(with: URL.init(string: avFile!.url!), placeholderImage: UIImage(named: "Cover"))
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView?.deselectRow(at: indexPath, animated: true)
        let bookDetailVC = BookDetailController()
        let object = self.dataArray[indexPath.row] as? AVObject
        bookDetailVC.bookObject = object
        bookDetailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(bookDetailVC, animated: true)
    }
    

    func setNavigationBar() {
        
        navigationView = UIView(frame: CGRect(x: 0, y: -20, width: SCREEN_WIDTH, height: 65))
        navigationView?.backgroundColor = UIColor.white
        
        self.navigationController?.navigationBar.addSubview(navigationView!)
        
        let addBookBtn = UIButton(frame: CGRect(x: 20, y: 20, width: SCREEN_WIDTH, height: 45))
        addBookBtn.setImage(UIImage.init(named: "plus circle"), for: .normal)
        addBookBtn.setTitleColor(UIColor.black, for: .normal)
        addBookBtn.setTitle("    新建标题", for: .normal)
        addBookBtn.titleLabel?.font = UIFont(name: MY_FONT, size: 15)
        addBookBtn.contentHorizontalAlignment = .left
        addBookBtn .addTarget(self, action: #selector(pushViewController.pushNewBook), for: .touchUpInside)
        navigationView?.addSubview(addBookBtn)
    }
    
    func pushNewBook() {
        
        let vc = pushNewBookController()
        GeneralFactory.addTitleWithTitle(target: vc, title1: "关闭", title2:"发布")
        self.present(vc, animated: true) { }
        
    }

}
