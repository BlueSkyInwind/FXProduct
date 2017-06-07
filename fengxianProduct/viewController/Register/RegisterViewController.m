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
    
    self.passwordTextField.delegate = self;
    self.confirmPasswordTextField.delegate = self;
    
}
#pragma mark - 点击事件
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
    [smsVM fatchRegisterVerifyCodeMoblieNumber:self.passwordTextField.text];
}
- (IBAction)scanInvationCodeClick:(id)sender {
    
    HMScannerController *scanner = [HMScannerController scannerWithCardName:nil avatar:nil completion:^(NSString *stringValue) {
        
        self.invationCode.text = stringValue;
    }];
    // 设置导航标题样式
    [scanner setTitleColor:[UIColor whiteColor] tintColor:UI_MAIN_COLOR];
    // 展现扫描控制器
    [self showDetailViewController:scanner sender:nil];
}
- (IBAction)registerCilck:(id)sender {
    RegisterViewModel * registerVM  = [[RegisterViewModel alloc]init];
    [registerVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            
        }
    } WithFaileBlock:^{
        
    }];
    if ([self checkInputValue]) {
        [registerVM fatchRegisterMoblieNumber:self.moblieNumber.text verifyCode:self.verificode.text password:self.passwordTextField.text inviteCode:self.invationCode.text];
    }
}
-(BOOL)checkInputValue{
    
    if(![Tool isMobileNumber:self.moblieNumber.text]){
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"手机号码格式错误"];
        return NO;
    }
    if(![self.verificode.text isEqualToString:@""] || self.verificode.text !=nil ){
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
