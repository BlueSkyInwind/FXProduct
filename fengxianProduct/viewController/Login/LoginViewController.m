//
//  LoginViewController.m
//  fengxianProduct
//
//  Created by admin on 2017/6/6.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.userNameTextField.delegate = self;
    self.password.delegate = self;

}
-(void)viewWillAppear:(BOOL)animated{
    [self.userNameTextField becomeFirstResponder];
    
}
#pragma  mrak - 点击事件
- (IBAction)loginBtnClick:(id)sender {
    

    
    
}
- (IBAction)goRegisterBtnClick:(id)sender {
    
    
    RegisterViewController * registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}
- (IBAction)goForgetPasswordClick:(id)sender {
    
    
}
- (IBAction)visitorModelCilck:(id)sender {
    
    
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
