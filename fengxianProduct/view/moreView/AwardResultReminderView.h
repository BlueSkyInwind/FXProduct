//
//  AwardResultReminderView.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/7/2.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CloseAwardResultView)(UIButton *button);
@interface AwardResultReminderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *conentImageView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (copy , nonatomic)CloseAwardResultView closeAwardResultView;

@end
