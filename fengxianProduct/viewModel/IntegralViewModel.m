//
//  IntegralViewModel.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/18.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "IntegralViewModel.h"
#import "integralModel.h"
@implementation IntegralViewModel

- (void)fatchAccountIntegral{
    
    //http://infx2.echaokj.cn/ajax/My/SignPro.ashx?AccountId=13
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@My/SignPro.ashx?AccountId=%@",_main_url,[Utility sharedUtility].userInfo.ID];
    
    [[FXNetworkManager sharedNetWorkManager]POSTHideIndicatorWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            integralModel * integralM = [[integralModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            self.returnBlock(integralM);
        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
    
}



@end