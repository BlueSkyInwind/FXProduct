//
//  SMSViewModel.m
//  fengxianProduct
//
//  Created by admin on 2017/6/7.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "SMSViewModel.h"

@implementation SMSViewModel

/**
 注册验证码

 @param number 手机号
 */
- (void)fatchRegisterVerifyCodeMoblieNumber:(NSString *)number{
    
    //http://infx2.echaokj.cn/ajax/inter/RegCode.ashx?Account=997530315@qq.com
    NSString * baseUrl = [NSString stringWithFormat:@"%@inter/RegCode.ashx?Account=%@",_main_url,number];
    
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        self.returnBlock(returnMsg);
    } failure:^(EnumServerStatus status, id object) {
        
//        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:object];
        [self faileBlock];
    }];

}
/**
 忘记密码验证码
 
 @param number 手机号
 */
- (void)fatchForgetPasswordVerifyCodeMoblieNumber:(NSString *)number{
    
    //http://infx2.echaokj.cn/ajax/inter/PassCode.ashx?Account=997530315@qq.com
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@inter/PassCode.ashx?Account=%@",_main_url,number];
    
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        self.returnBlock(returnMsg);
    } failure:^(EnumServerStatus status, id object) {
        
//        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:object];
        [self faileBlock];
    }];
    
}

@end
