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
        switch indexPath.row {
        case 0:
            cell.detailTextLabel?.text = self.Book_title
            break
        case 1:
            
            break
        case 2:
            
            break
        case 3:
            
            break
            
        default:
            
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView?.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
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
        
    }
    
    //选择分类
    func tableViewSelectType() {
        let pushTitle = Push_TypeController()
        GeneralFactory.addTitleWithTitle(target: pushTitle)
        self.present(pushTitle, animated: true) {
            
        }
    }
    
    //选择书评
    func tableViewSelectDespription() {
        let pushTitle = Push_DescriptionController()
        GeneralFactory.addTitleWithTitle(target: pushTitle)
        self.present(pushTitle, animated: true) {
            
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
        
    }

}
