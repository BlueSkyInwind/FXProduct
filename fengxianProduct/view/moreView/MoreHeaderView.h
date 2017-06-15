//
//  MoreHeaderView.h
//  fengxianProduct
//
//  Created by admin on 2017/6/8.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^QRCodeBtnClick)(UIButton * button);
typedef void(^GoUserInfoBtnClick)(UITapGestureRecognizer * tap);

@interface MoreHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *IDLabel;

@property (weak, nonatomic) IBOutlet UIButton *qrCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *userHeaderImageBtn;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *IDleftConstraint;

@property (nonatomic,copy)QRCodeBtnClick qRCodeBtnClick;
@property (nonatomic,copy)GoUserInfoBtnClick goUserInfoBtnClick;


-(void)configureViewImage:(NSString *)imageUrl AccountID:(NSString *)accountID userNickName:(NSString *)nickName;

@end
