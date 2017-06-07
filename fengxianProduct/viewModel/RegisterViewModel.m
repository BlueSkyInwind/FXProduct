//
//  RegisterViewModel.m
//  fengxianProduct
//
//  Created by admin on 2017/6/7.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "RegisterViewModel.h"

@implementation RegisterViewModel

/**
 注册接口

 @param number 手机号
 @param verifyCode 验证码
 @param password 密码
 @param inviteCode 邀请码 （可选）
 */
- (void)fatchRegisterMoblieNumber:(NSString *)number verifyCode:(NSString *)verifyCode password:(NSString *)password inviteCode:(NSString *)inviteCode{

    //http://infx2.echaokj.cn/ajax/inter/Registered.ashx?Account=997530315@qq.com&Pass=111111&Code=2134&InviteCode=
    NSString * baseUrl = [NSString stringWithFormat:@"%@inter/Registered.ashx?Account=%@&Pass=%@&Code=%@&InviteCode=%@",_main_url,number,password,verifyCode,inviteCode];
    
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        self.returnBlock(returnMsg);
        
    } failure:^(EnumServerStatus status, id object) {
        
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:object];
        [self faileBlock];
        
    }];
}




@end
