//
//  PushBook.swift
//  GoodBook
//
//  Created by zhy on 17/3/29.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

class PushBook: NSObject {

    static func pushBookInBack(dict : NSDictionary) {
    
        
        let object = AVObject(className: "Book")
        //书名
        object.setObject(dict["BookName"], forKey: "BookName")
        //作者
        object.setObject(dict["BookEditor"], forKey: "BookEditor")
        //标题
        object.setObject(dict["Title"], forKey: "Title")
        //评分
        object.setObject(dict["Score"], forKey: "Score")
        //类型
        object.setObject(dict["Type"], forKey: "Type")
        //类型详情
        object.setObject(dict["DetailType"], forKey: "DetailType")
        //描述
        object.setObject(dict["Description"], forKey: "Description")
        
        //封面
        let cover = dict["BookCover"] as? UIImage
        let coverFile = AVFile(data: UIImagePNGRepresentation(cover!)!)
        coverFile.saveInBackground { (success, error) in
            
            if success {
            
                object.setObject(coverFile, forKey: "Cover")
                object.saveInBackground({ (success, error) in
                    
                    if success {
                    
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushBookNotifation"), object: nil, userInfo: ["success":"true"])
                    }else {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushBookNotifation"), object: nil, userInfo: ["success":"false"])
                    }
                })
            }else {
            
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushBookNotifation"), object: nil, userInfo: ["success":"false"])
            }
            
        }
        
        
    }

}
