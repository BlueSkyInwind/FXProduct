//
//  ForgetPasswordViewController.h
//  fengxianProduct
//
//  Created by admin on 2017/6/7.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YX_TextField.h"
@interface ForgetPasswordViewController : BaseViewController

@property (weak, nonatomic) IBOutlet YX_TextField *moblieTextField;

@property (weak, nonatomic) IBOutlet YX_TextField *verifyCodeTextField;

@property (weak, nonatomic) IBOutlet YX_TextField *passwordTextField;

@property (weak, nonatomic) IBOutlet YX_TextField *confirmPasswordTextField;

@property (weak, nonatomic) IBOutlet UIButton *getVerifyCodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;


@end
