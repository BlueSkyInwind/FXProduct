//
//  MoreNavView.h
//  fengxianProduct
//
//  Created by admin on 2017/6/8.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoreNavViewDelegate <NSObject>
-(void)CollectViewCilck;
-(void)DiscloseViewCilck;
-(void)EmailViewCilck;
-(void)SignInViewCilck;

@end

@interface MoreNavView : UIView

@property (weak, nonatomic) IBOutlet UIView *collectView;

@property (weak, nonatomic) IBOutlet UIView *discloseView;

@property (weak, nonatomic) IBOutlet UIView *emailView;

@property (weak, nonatomic) IBOutlet UIView *signInView;

@property (weak, nonatomic) IBOutlet UILabel *signLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailBadgeNum;


@property (assign , nonatomic)id<MoreNavViewDelegate>delegate;

@end
