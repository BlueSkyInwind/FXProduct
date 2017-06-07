//
//  RegisterViewController.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/6.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YX_TextField.h"

@interface RegisterViewController : BaseViewController

@property (weak, nonatomic) IBOutlet YX_TextField *moblieNumber;

@property (weak, nonatomic) IBOutlet YX_TextField *verificode;

@property (weak, nonatomic) IBOutlet YX_TextField *passwordTextField;

@property (weak, nonatomic) IBOutlet YX_TextField *confirmPasswordTextField;

@property (weak, nonatomic) IBOutlet UITextField *invationCode;

@property (weak, nonatomic) IBOutlet UIButton *getVerifyCodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *scanInvationCodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (weak, nonatomic) IBOutlet UILabel *explainLabel;

@property (weak, nonatomic) IBOutlet UILabel *AgreementLabel;

@end
