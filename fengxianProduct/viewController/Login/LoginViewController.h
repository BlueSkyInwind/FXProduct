//
//  LoginViewController.h
//  fengxianProduct
//
//  Created by admin on 2017/6/6.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "YX_TextField.h"

@interface LoginViewController : BaseViewController

@property (weak, nonatomic) IBOutlet YX_TextField *userNameTextField;

@property (weak, nonatomic) IBOutlet YX_TextField *password;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *goRegisterBtn;

@property (weak, nonatomic) IBOutlet UIButton *goForgetPassword;

@property (weak, nonatomic) IBOutlet UIButton *visitorBtn;





@end
