//
//  RegisterViewController.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/6.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "RegisterViewController.h"
#import "SMSViewModel.h"
#import "RegisterViewModel.h"
#import "HMScannerController.h"
#import "FXWebViewController.h"
#import "AgreementViewModel.h"
#import "lhScanQCodeViewController.h"
#import "loginViewMdoel.h"

@interface RegisterViewController ()<UITextFieldDelegate>{
    
    NSInteger _countdown;
    NSTimer * _countdownTimer;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"注册";
    _countdown = 60;
    [self addBackItem];
    [self configureView];
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
-(void)configureView{
    
    NSString * str = self.explainLabel.text;
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    [attributedString addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(1, 1)];
    self.explainLabel.attributedText = attributedString;
    
    NSString * str1 = self.AgreementLabel.text;
    NSRange range =  [str1 rangeOfString:@"《"];
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc]initWithString:str1];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(range.location, str1.length - range.location)];
    self.AgreementLabel.attributedText = attributedString1;
    
    UITapGestureRecognizer * agreementTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(registerAgreementTap)];
    [self.AgreementLabel addGestureRecognizer:agreementTap];
    
    self.passwordTextField.delegate = self;
    self.confirmPasswordTextField.delegate = self;
    self.verificode.delegate = self;
}
#pragma mark - 点击事件
-(void)registerAgreementTap{
    
    AgreementViewModel * agreementVM = [[AgreementViewModel alloc]init];
    [agreementVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            FXWebViewController * webVC = [[FXWebViewController alloc]init];
            webVC.title = returnMsg.result[@"Title"];
            webVC.Content = returnMsg.result[@"Information"];
            [self.navigationController pushViewController:webVC animated:YES];
        }
    } WithFaileBlock:^{
        
    }];
    [agreementVM fatchRegisterAgreement:3];
    
}


- (IBAction)getVerifyCodeClick:(id)sender {
    [self.view endEditing:YES];
    
    if(![Tool isMobileNumber:self.moblieNumber.text]){
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
    [smsVM fatchRegisterVerifyCodeMoblieNumber:self.moblieNumber.text];
}
- (IBAction)scanInvationCodeClick:(id)sender {
   
    __weak typeof(self) weakSelf = self;
    lhScanQCodeViewController * lhScanQCodeVC = [[lhScanQCodeViewController alloc]init];
    lhScanQCodeVC.scanQRCodeResult = ^(NSString *resultStr) {
        weakSelf.invationCode.text = resultStr;
    };
    [self.navigationController pushViewController:lhScanQCodeVC animated:YES];
}
- (IBAction)registerCilck:(id)sender {
    RegisterViewModel * registerVM  = [[RegisterViewModel alloc]init];
    [registerVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            //注册成功处理
            [self userlogin];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:(NSString *)returnMsg.msg];
        }
    } WithFaileBlock:^{
        
    }];
    if ([self checkInputValue]) {
        [registerVM fatchRegisterMoblieNumber:self.moblieNumber.text verifyCode:self.verificode.text password:self.passwordTextField.text inviteCode:self.invationCode.text];
    }
}
-(void)userlogin{
    
    loginViewMdoel * loginVM = [[loginViewMdoel alloc]init];
    [loginVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            [Tool saveUserDefaul:dic Key:FX_CommentTimeInfo];
            dispatch_async(dispatch_get_main_queue(), ^{
                ((AppDelegate *)[UIApplication sharedApplication].delegate).btb.selectedIndex = 0;
                app.btb = [[BaseTabBarViewController alloc]init];
                app.window.rootViewController = app.btb;
                
                //                [self dismissViewControllerAnimated:YES completion:^{
                //                    ((AppDelegate *)[UIApplication sharedApplication].delegate).btb.selectedIndex = 0;
                //                }];
            });
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:(NSString *)returnMsg.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [loginVM fatchLoginMoblieNumber:self.moblieNumber.text password:self.passwordTextField.text];
}

-(BOOL)checkInputValue{
    
    if(![Tool isMobileNumber:self.moblieNumber.text]){
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"手机号码格式错误"];
        return NO;
    }
    if([self.verificode.text isEqualToString:@""] || self.verificode.text ==nil ){
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
    
    if ([textField isEqual:self.verificode]) {
        NSString *stringLength=[NSString stringWithFormat:@"%@%@",self.verificode.text,string];
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
