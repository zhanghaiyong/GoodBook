//
//  InputView.h
//  GoodBook
//
//  Created by zhy on 17/4/6.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InputView;
@protocol InputViewDelegate <NSObject>

- (void)keyBoardWillShow:(InputView *)view keyBoardH:(CGFloat)keyBoardH animationDuration:(NSTimeInterval)duration animationCurve:(UIViewAnimationCurve)animationCurve;

- (void)keyBoardWillHide:(InputView *)view keyBoardH:(CGFloat)keyBoardH animationDuration:(NSTimeInterval)duration animationCurve:(UIViewAnimationCurve)animationCurve;

- (void)textViewHeightDidChange:(CGFloat)height;

- (void)releaseComment:(NSString *)comment;

@end

@interface InputView : UIView<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic,assign)id<InputViewDelegate>delegate;

@end
