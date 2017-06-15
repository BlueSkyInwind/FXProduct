//
//  FeedbackViewController.h
//  fengxianProduct
//
//  Created by admin on 2017/6/15.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "BaseViewController.h"
#import "XXTextView.h"

@interface FeedbackViewController : BaseViewController
@property (weak, nonatomic) IBOutlet XXTextView *contentTextView;


@property (weak, nonatomic) IBOutlet UIButton *imageBtn;

@property (weak, nonatomic) IBOutlet UITextField *contactWayTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end
