//
//  InputView.m
//  GoodBook
//
//  Created by zhy on 17/4/6.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

#import "InputView.h"

@implementation InputView

-(void)awakeFromNib {

    [super awakeFromNib];
    
    self.textView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyBoardWillShow:(NSNotification *)notification {

    //键盘frame
    CGRect keyBoardFrame;
    [notification.userInfo[UIKeyboardFrameEndUserInfoKey] getValue:&keyBoardFrame];
    
    //键盘显示时间
    double duration;
    [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] getValue:&duration];
    
    //键盘动画
    UIViewAnimationCurve curve;
    [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] getValue:&curve];
    
    
    if ([self.delegate respondsToSelector:@selector(keyBoardWillShow:keyBoardH:animationDuration:animationCurve:)]) {
        
        [self.delegate keyBoardWillShow:self keyBoardH:keyBoardFrame.size.height animationDuration:duration animationCurve:curve];
    }
}

- (void)keyBoardWillHide:(NSNotification *)notification {
    
    //键盘frame
    CGRect keyBoardFrame;
    [notification.userInfo[UIKeyboardFrameEndUserInfoKey] getValue:&keyBoardFrame];
    
    //键盘显示时间
    double duration;
    [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] getValue:&duration];
    
    //键盘动画
    UIViewAnimationCurve curve;
    [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] getValue:&curve];
    
    if ([self.delegate respondsToSelector:@selector(keyBoardWillHide:keyBoardH:animationDuration:animationCurve:)]) {
        
        [self.delegate keyBoardWillHide:self keyBoardH:keyBoardFrame.size.height animationDuration:duration animationCurve:curve];
    }
}

#pragma mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {

    CGRect frame = [self.textView.text boundingRectWithSize:CGSizeMake(self.textView.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textView.font} context:nil];
    
    if ([self.delegate respondsToSelector:@selector(textViewHeightDidChange:)]) {
        
        [self.delegate textViewHeightDidChange:frame.size.height];
    }
}

- (IBAction)releaseAction:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(releaseComment:)]) {
        
        [self.delegate releaseComment:self.textView.text];
    }
}

@end
