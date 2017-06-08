//
//  MoreViewModel.m
//  fengxianProduct
//
//  Created by admin on 2017/6/8.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MoreViewModel.h"

@implementation MoreViewModel

/**
 用户信息获取接口
 */
- (void)obtainAccountInfo{
    
     //http://infx2.echaokj.cn/ajax/inter/UserQuery.ashx?AccountId=10
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@inter/UserQuery.ashx?AccountId=%@",_main_url,[Utility sharedUtility].userInfo.ID];
    
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            DLog(@"获取成功");
            if (!returnMsg.result) {
                return;
            }
            UserInfoObj * userInfo = [[UserInfoObj alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            [Utility sharedUtility].userInfo = userInfo;
            if ( [Utility sharedUtility].userInfo.ID != nil || ![[Utility sharedUtility].userInfo.ID isEqualToString:@""]) {
                [Tool saveUserDefaul:[object objectForKey:@"result"] Key:FX_AccountID];
            }
        }else{
            
        }
        self.returnBlock(returnMsg);
    } failure:^(EnumServerStatus status, id object) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:object];
        [self faileBlock];
    }];
    
}
@end
