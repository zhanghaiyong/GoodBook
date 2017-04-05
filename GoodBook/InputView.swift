//
//  InputView.swift
//  GoodBook
//
//  Created by zhy on 17/4/1.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

protocol InputViewDelegate {
    
    func keyboardWillShow(inputView : InputView,keyBoardH : CGFloat,duration : TimeInterval,animation : UIViewAnimationCurve)
    func keyboardWillHide(inputView : InputView,keyBoardH : CGFloat,duration : TimeInterval,animation : UIViewAnimationCurve)
    func textViewHeightDidChange(height : CGFloat)
}

class InputView: UIView,UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    var delegate : InputViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.textView.delegate = self;
        
        //注册键盘通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notifation:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notifation:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    @IBAction func subitAction(_ sender: Any) {
    }
    
    
    //键盘通知
    func keyBoardWillShow(notifation : Notification) {
        
        //键盘frame
        let frame = notifation.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect
        let animationCurve = notifation.userInfo?[UIKeyboardAnimationCurveUserInfoKey]
        let duration = notifation.userInfo?[UIKeyboardAnimationDurationUserInfoKey]
        self.delegate?.keyboardWillShow(inputView: self, keyBoardH: (frame?.size.height)!, duration: duration as! TimeInterval, animation: animationCurve as! UIViewAnimationCurve)
        
    }
    
    func keyBoardWillHide(notifation : Notification) {
        
        //键盘frame
        let frame = notifation.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect
        let animationCurve = notifation.userInfo?[UIKeyboardAnimationCurveUserInfoKey]
        let duration = notifation.userInfo?[UIKeyboardAnimationDurationUserInfoKey]
        self.delegate?.keyboardWillHide(inputView: self, keyBoardH: (frame?.size.height)!, duration: duration as! TimeInterval, animation: animationCurve as! UIViewAnimationCurve)
    }
    
    //UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        
//        var rect = self.textView.text.boundingRectWithSize(CGSizeMake(self.frame.size.width-16,CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attribute_set as [NSObject : AnyObject], context:nil)
        
    }
}









