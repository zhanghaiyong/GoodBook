//
//  pushNewBookController.swift
//  GoodBook
//
//  Created by zhy on 17/3/23.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

class pushNewBookController: UIViewController,bookTitleDelegate,PhotoPickerDelegate {

    
    var BookTitle : BookTitleView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.BookTitle = BookTitleView(frame: CGRect(x: 0, y: 40, width: SCREEN_WIDTH, height: 160))
        self.BookTitle!.delegate = self;
        self.view.addSubview(self.BookTitle!)
        
    }

    //BookTitleDelegate
    func choiceCover() {
        
        print("choiceCover")
        
        let photoPicker = photoPickerViewController()
        photoPicker.delegate = self
        
        self.present(photoPicker, animated: true) {
            
        }
    }
    
    //photoPickerDelegate
    func getImageFromPicker(image: UIImage) {
        
        self.BookTitle?.BookCover?.setImage(image, for: .normal)
    }

    func closeAction() {
        
        self.dismiss(animated: true) { 
            
        }
    }
    
    func sureAction() {
        
    }

}
