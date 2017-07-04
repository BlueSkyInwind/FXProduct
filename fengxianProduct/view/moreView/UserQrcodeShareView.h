//
//  UserQrcodeShareView.h
//  fengxianProduct
//
//  Created by admin on 2017/6/9.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol UserQrcodeShareViewDelegate  <NSObject>

-(void)closeViewClick;
-(void)invationCodeClick;

@end


@interface UserQrcodeShareView : UIView


@property (weak, nonatomic) IBOutlet UIImageView *userAvatarImage;

@property (weak, nonatomic) IBOutlet UILabel *invationCodeLabel;


@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImage;

@property (weak, nonatomic) IBOutlet UIButton *invationBtn;

@property (weak, nonatomic) IBOutlet UILabel *explainLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *invationBtnRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *explainLabelWidth;

@property (nonatomic,assign)id<UserQrcodeShareViewDelegate> delegate;

-(void)configureView;

@end
