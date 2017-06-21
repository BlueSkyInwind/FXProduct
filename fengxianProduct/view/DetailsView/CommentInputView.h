//
//  CommentInputView.h
//  fengxianProduct
//
//  Created by admin on 2017/6/20.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CancelButtonClick)(UIButton * button);
typedef void (^SureButtonClick)(UIButton * button);

@interface CommentInputView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancalBtn;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@property (copy,nonatomic)CancelButtonClick cancelButtonClick;

@property (copy,nonatomic)SureButtonClick sureButtonClick;



@end
