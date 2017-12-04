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
#import "AppDelegate.h"
#import "UserInfoViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"登录";
    self.userNameTextField.delegate = self;
    self.password.delegate = self;
//    [self addBackItem];
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

    app.btb = [[BaseTabBarViewController alloc]init];
    app.btb.selectedIndex = 0;
    app.window.rootViewController = app.btb;
    
//    [self dismissViewControllerAnimated:YES completion:^{
//        ((AppDelegate *)[UIApplication sharedApplication].delegate).btb.selectedIndex = 0;
//    }];
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

-(NSString *)isStopSever{
    
    PFLiveQueryClient *liveQueryClient = [[PFLiveQueryClient alloc] initWithServer:@"wss://livequeryexample.back4app.io" applicationId:@"Tl5Pv4r2w36T5HXKCEeWMJWUSG58aRJvIYpAFpPi" clientKey:@"LiGEjJFhWjAwDrFBuYM0Rxk00d9Eh5dUEZj5e3s1"];
    PFQuery *msgQuery = [PFQuery queryWithClassName:@"check"];
    PFObject * object =   [msgQuery getObjectWithId:@"L3N5NGzk2G"];
    NSString * str = object[@"stopSever"];
    return str;
    
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
