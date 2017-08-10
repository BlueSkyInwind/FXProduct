//
//  LiveViewModel.m
//  fengxianProduct
//
//  Created by admin on 2017/6/28.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "LiveViewModel.h"
#import "LiveMessageModel.h"

@implementation LiveViewModel

- (void)fatchLivesColumnBadgeValue{
    
    //http://infx2.echaokj.cn/ajax/Home/NewList.ashx?ColumnID=11&PageSize=1&PageCount=10
    
    NSString * accountId = [Utility sharedUtility].userInfo.ID;
    if ([Utility sharedUtility].userInfo.ID == nil) {
        accountId = @"0";
    }
    NSString * baseUrl = [NSString stringWithFormat:@"%@Life/LifesList2.ashx?Column=5,6,7,8&AccountId=%@",_main_url,accountId];
    
    [[FXNetworkManager sharedNetWorkManager]POSTWithNetworkStatusURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            LiveMessageModel * liveMessageModel = [[LiveMessageModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            self.returnBlock(liveMessageModel);
        }
    } failure:^(EnumServerStatus status, id object) {
//        NSError * error = object;
//        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}


@end
