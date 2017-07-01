//
//  loginViewMdoel.m
//  fengxianProduct
//
//  Created by admin on 2017/6/7.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "loginViewMdoel.h"
#import "UserInfoObj.h"
#import "NewsViewModel.h"
#import "JPUSHService.h"
@implementation loginViewMdoel

- (void)fatchLoginMoblieNumber:(NSString *)number password:(NSString *)password{
    
    //http://infx2.echaokj.cn/ajax/inter/Login.ashx?Account=cynthia@echaokj.cn&Pass=00000000
    NSString * baseUrl = [NSString stringWithFormat:@"%@inter/Login.ashx?Account=%@&Pass=%@",_main_url,number,password];
    
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            DLog(@"登录成功");
            if (!returnMsg.result) {
                return;
            }
            UserInfoObj * userInfo = [[UserInfoObj alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            [Utility sharedUtility].userInfo = userInfo;
            [Utility sharedUtility].loginFlage = YES;
            if ([Utility sharedUtility].userInfo.ID != nil || ![[Utility sharedUtility].userInfo.ID isEqualToString:@""]) {
                [Tool saveUserDefaul:@"1" Key:kLoginFlag];
                [Tool saveUserDefaul:[object objectForKey:@"result"] Key:FX_AccountID];
            }
            NewsViewModel * newVM = [[NewsViewModel alloc]init ];
            [newVM uploadPushID:[JPUSHService registrationID]];
        }else{
            
        }
        self.returnBlock(returnMsg);
    } failure:^(EnumServerStatus status, id object) {
        
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:object];
        [self faileBlock];
    }];
}



@end
