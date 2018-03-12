//
//  ForgetPasswordViewModel.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/7.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ForgetPasswordViewModel.h"

@implementation ForgetPasswordViewModel


/**
 忘记密码

 @param number 手机号码
 @param verifyCode 验证码
 @param password 密码
 */
- (void)fatchForgetPasswordMoblieNumber:(NSString *)number verifyCode:(NSString *)verifyCode password:(NSString *)password{
    
    //http://infx2.echaokj.cn/ajax/inter/PassUpdate.ashx?Account=997530315@qq.com&Pass=111111&Code=2134
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@inter/PassUpdate.ashx?Account=%@&Pass=%@&Code=%@",_main_url,number,password,verifyCode];
    
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"密码修改成功"];
        }
        self.returnBlock(returnMsg);
    } failure:^(EnumServerStatus status, id object) {
        
//        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:object];
        [self faileBlock];
        
    }];
}


@end
