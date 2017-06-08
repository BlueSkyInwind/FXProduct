//
//  AgreementViewModel.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/7.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "AgreementViewModel.h"

@implementation AgreementViewModel


/**
 协议，积分说明北荣获取

 @param type 1、积分说明 2、关于我们  3、用户注册协议
 */
- (void)fatchRegisterAgreement:(int)type{
    
    //http://infx2.echaokj.cn/ajax/Basic/TextDetail.ashx?id=1
    NSString * baseUrl = [NSString stringWithFormat:@"%@Basic/TextDetail.ashx?id=%@",_main_url,[NSNumber numberWithInt:type]];
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        self.returnBlock(returnMsg);
        
    } failure:^(EnumServerStatus status, id object) {
        
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:object];
        [self faileBlock];
        
    }];
}



@end
