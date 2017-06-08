//
//  ForgetPasswordViewController.m
//  fengxianProduct
//
//  Created by admin on 2017/6/7.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "SMSViewModel.h"
#import "ForgetPasswordViewModel.h"
@interface ForgetPasswordViewController ()<UITextFieldDelegate>{
    NSInteger _countdown;
    NSTimer * _countdownTimer;

}


@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"忘记密码";
    _countdown = 60;

    self.passwordTextField.delegate = self;
    self.confirmPasswordTextField.delegate = self;
    self.verifyCodeTextField.delegate = self;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_countdownTimer invalidate];
}

#pragma mark - 点击事件
- (IBAction)verifyCodeBtnClick:(id)sender {
    [self.view endEditing:YES];
    
    if(![Tool isMobileNumber:self.moblieTextField.text]){
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"手机号码格式错误"];
        return;
    }
    
    SMSViewModel * smsVM = [[SMSViewModel alloc]init];
    [smsVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            [self setSMSBtnInvalid];
        }else{
            [self.getVerifyCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:(NSString *)returnMsg.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [smsVM fatchForgetPasswordVerifyCodeMoblieNumber:self.moblieTextField.text];
}
- (IBAction)sureBtnCilck:(id)sender {
    
    ForgetPasswordViewModel * forgetPasswordVM = [[ForgetPasswordViewModel alloc]init];
    [forgetPasswordVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            
            [self.navigationController popViewControllerAnimated:YES
             ];
            
        }else{
            
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:(NSString *)returnMsg.msg];
        }
    } WithFaileBlock:^{
        
    }];
    if ([self checkInputValue]) {
        [forgetPasswordVM fatchForgetPasswordMoblieNumber:self.moblieTextField.text verifyCode:self.verifyCodeTextField.text password:self.passwordTextField.text];
    }
}
-(BOOL)checkInputValue{
    
    if([self.moblieTextField.text isEqualToString:@""] || self.verifyCodeTextField.text ==nil){
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入手机号或邮箱"];
        return NO;
    }
    if([self.verifyCodeTextField.text isEqualToString:@""] || self.verifyCodeTextField.text ==nil ){
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入验证码"];
        return NO;
    }
    if(self.passwordTextField.text.length < 6){
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请保持密码长度在6~16位"];
        return NO;
    }
    if (![self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text]) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"两次输入密码不一致！"];
        return NO;
    }
    
    return YES;
}
#pragma mark - 验证码
- (void)setSMSBtnInvalid
{
    self.getVerifyCodeBtn.userInteractionEnabled = NO;
    self.getVerifyCodeBtn.alpha = 0.4;
    [self.getVerifyCodeBtn setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)(_countdown - 1)] forState:UIControlStateNormal];
    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButtonUser) userInfo:nil repeats:YES];
}

- (void)closeGetVerifyButtonUser
{
    _countdown -= 1;
    [self.getVerifyCodeBtn setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)_countdown] forState:UIControlStateNormal];
    if(_countdown == 0){
        self.getVerifyCodeBtn.userInteractionEnabled = YES;
        [self.getVerifyCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        self.getVerifyCodeBtn.alpha = 1.0;
        _countdown = 60;
        //注意此处不是暂停计时器,而是彻底注销,使_countdownTimer.valid == NO;
        [_countdownTimer invalidate];
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([textField isEqual:self.verifyCodeTextField]) {
        NSString *stringLength=[NSString stringWithFormat:@"%@%@",self.verifyCodeTextField.text,string];
        if ([stringLength length]>4) {
            return NO;
        }
        return YES;
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:KCharacterNumber] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filtered];
    //        NSString *stringLength=[NSString stringWithFormat:@"%@%@",self.userNameTextField.text,string];
    if (canChange) {
        return YES;
    }else{
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
