//
//  LoginViewController.m
//  fengxianProduct
//
//  Created by admin on 2017/6/6.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "loginViewMdoel.h"
@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"登录";
    self.userNameTextField.delegate = self;
    self.password.delegate = self;
    [self addBackItem];
}
-(void)viewWillAppear:(BOOL)animated{
    
}

#pragma  mrak - 点击事件
- (IBAction)loginBtnClick:(id)sender {
    
    if(self.password.text.length < 6){
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请保持密码长度在6~16位"];
        return;
    }
    loginViewMdoel * loginVM = [[loginViewMdoel alloc]init];
    [loginVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:^{
                }];
            });

        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:(NSString *)returnMsg.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [loginVM fatchLoginMoblieNumber:self.userNameTextField.text password:self.password.text];
    
}
- (IBAction)goRegisterBtnClick:(id)sender {
    
    
    RegisterViewController * registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}
- (IBAction)goForgetPasswordClick:(id)sender {
    
    ForgetPasswordViewController * forgetPasswordVC = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:forgetPasswordVC animated:YES];
    
}
- (IBAction)visitorModelCilck:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
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
