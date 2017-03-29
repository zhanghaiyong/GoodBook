//
//  pushNewBookController.swift
//  GoodBook
//
//  Created by zhy on 17/3/23.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

class pushNewBookController: UIViewController,bookTitleDelegate,PhotoPickerDelegate,VPImageCropperDelegate,UITableViewDelegate,UITableViewDataSource {

    
    var BookTitle : BookTitleView?
    var tableView : UITableView?
    var titleArray : Array<String> = []
    var Book_title = ""
    var Book_Type = ""
    var Book_DetailType = ""
    var Book_description = ""
    var score : LDXScore?
    //是否显示星星
    var showScore : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.BookTitle = BookTitleView(frame: CGRect(x: 0, y: 40, width: SCREEN_WIDTH, height: 160))
        self.BookTitle!.delegate = self;
        self.view.addSubview(self.BookTitle!)
        
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 200, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-200), style: .grouped)
        self.tableView?.tableFooterView = UIView()
        self.tableView?.delegate = self;
        self.tableView?.dataSource = self
        //注册cell
        self.tableView?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView?.backgroundColor = UIColor(colorLiteralRed: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        self.view.addSubview(self.tableView!)
        
        
        self.titleArray = ["标题","评分","分类","书评"]
        
        
        self.score = LDXScore(frame: CGRect(x: 100, y: 10, width: 100, height: 22))
        self.score?.isSelect = true
        self.score?.normalImg = UIImage(named: "btn_star_evaluation_normal")
        self.score?.highlightImg = UIImage(named: "btn_star_evaluation_press")
        self.score?.max_star = 5
        self.score?.show_star = 5;
        
        NotificationCenter.default.addObserver(self, selector: Selector(("pushBookNotification:")), name: NSNotification.Name(rawValue: "pushBookNotification"), object: nil)
    }
    
    func pushBookNotification(notication : NSNotification) {
        
        let dict = notication.userInfo
        if String(describing: dict!["success"]!) == "true"{
            ProgressHUD.showSuccess("上传成功")
            self.dismiss(animated: true, completion: { () -> Void in
                
            })
        }else{
            ProgressHUD.showError("上传失败")
        }
    }
    
    deinit {
    
        NotificationCenter.default.removeObserver(self)
        
        //打印了就没有发生内存泄露
        print("ddd");
    }
    
    //UITableViewDelegate&&dataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        //避免cell内容重叠
        for view in cell.contentView.subviews {
            
            view.removeFromSuperview()
        }
        
        //cell上面加一个箭头
        if indexPath.row != 1 {
            cell.accessoryType = .disclosureIndicator
        }
        
        cell.textLabel?.text = self.titleArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: MY_FONT, size: 15)
        cell.detailTextLabel?.font = UIFont(name: MY_FONT, size: 13)
        
        var row = indexPath.row
        
        if self.showScore && row>=1 {
            row -= 1
        }
        
        switch row {
        case 0:
            cell.detailTextLabel?.text = self.Book_title
            break
        case 2:
            cell.detailTextLabel?.text = self.Book_Type + " " + self.Book_DetailType
            break
        case 3:
            cell.detailTextLabel?.text = self.Book_description
            break
        default:
            break
        }
        
        if self.showScore && indexPath.row == 2 {
            
            cell.contentView.addSubview(score!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView?.deselectRow(at: indexPath, animated: true)
        
        var row = indexPath.row
        
        if self.showScore && row>1 {
            row -= 1
        }
        
        
        switch row {
        case 0:
            self.tableViewSelectTitle()
            
            break
        case 1:
            
            self.tableViewSelectRank()
            break
        case 2:
            
            self.tableViewSelectType()
            break
        case 3:
            
            self.tableViewSelectDespription()
            break
        default:
            break
        }
    }
    
    
    //选择title
    func tableViewSelectTitle() {
        let pushTitle = Push_TitleController()
        pushTitle.callBack = ({(Title:String) -> Void in
        
            self.Book_title = Title
            self.tableView?.reloadData()
            
        })
        
        GeneralFactory.addTitleWithTitle(target: pushTitle)
        self.present(pushTitle, animated: true) { 
            
        }
    }
    
    //选择评分
    func tableViewSelectRank() {
        
        self.tableView?.beginUpdates()
        let tempIndexPath = [NSIndexPath(item: 2, section: 0)]
        if self.showScore {
            self.showScore = false
            self.titleArray.remove(at: 2)
            self.tableView?.deleteRows(at: tempIndexPath as [IndexPath], with: .right)
            
        }else {
        
            self.showScore = true
            self.titleArray.insert("", at: 2)
            
            self.tableView?.insertRows(at: tempIndexPath as [IndexPath], with: .left)
            
        }
        self.tableView?.endUpdates()

    }
    
    //选择分类
    func tableViewSelectType() {
        let pushType = Push_TypeController()
        GeneralFactory.addTitleWithTitle(target: pushType)
        let btn1 = pushType.view.viewWithTag(100) as! UIButton
        let btn2 = pushType.view.viewWithTag(101) as! UIButton
        btn1 .setTitleColor(RGB(r: 38,g: 82,b: 67), for: .normal)
        btn2 .setTitleColor(RGB(r: 38,g: 82,b: 67), for: .normal)
        
        pushType.callBack = ({(_ type: String,_ detail: String) -> Void in
            
            self.Book_Type = type
            self.Book_DetailType = detail
            self.tableView?.reloadData()
            
            })
        
        self.present(pushType, animated: true) {
            
        }
    }
    
    //选择书评
    func tableViewSelectDespription() {
        let pushDescription = Push_DescriptionController()
        pushDescription.callBack = ({(_ description : String) -> Void in
        
            self.Book_description = description
            self.tableView?.reloadData()
        })
        
        GeneralFactory.addTitleWithTitle(target: pushDescription)
        self.present(pushDescription, animated: true) {
            
        }
    }
    

    //BookTitleDelegate
    func choiceCover() {
        
        let photoPicker = photoPickerViewController()
        photoPicker.delegate = self
        
        self.present(photoPicker, animated: true) {
            
        }
    }
    
    //photoPickerDelegate
    func getImageFromPicker(image: UIImage) {
        
        //剪裁
        let CroVC = VPImageCropperViewController.init(image: image, cropFrame: CGRect(x: 0,y: 100,width: SCREEN_WIDTH,height: SCREEN_WIDTH), limitScaleRatio: 1)
        CroVC?.delegate = self
        self.present((CroVC)!, animated: true) {
            
        }
    }
    
    //VPImageCropperViewDelegate
    func imageCropperDidCancel(_ cropperViewController: VPImageCropperViewController!) {
        
        cropperViewController.dismiss(animated: true) { 
            
        }
    }
    
    func imageCropper(_ cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
        
        self.BookTitle?.BookCover?.setImage(editedImage, for: .normal)
        cropperViewController.dismiss(animated: true) {
            
        }
    }

    //关闭
    func closeAction() {
        
        self.dismiss(animated: true) { 
            
        }
    }
    
    //发布
    func sureAction() {
        
        let dict = [
        
            "BookName":(self.BookTitle?.BookName?.text)! as String,
            "BookEditor":(self.BookTitle?.BookEditor?.text)! as String ,
            "BookCover":(self.BookTitle?.BookCover?.currentImage)! as UIImage,
            "Title":self.Book_title,
            "Score":String((self.score?.show_star)!),
            "Type":self.Book_Type,
            "DetaileType":self.Book_DetailType,
            "Description":self.Book_description
        ] as [String : Any]
        
        PushBook.pushBookInBack(dict: dict as NSDictionary)
    }

}
