//
//  ColumnViewModel.m
//  fengxianProduct
//
//  Created by admin on 2017/6/13.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ColumnViewModel.h"

@implementation ColumnViewModel


- (void)uploadColumnListType:(NSString *)number Column:(NSString *)Column{
    
    //http://infx2.echaokj.cn/ajax/User/ColumnUser.ashx?AccountId=20&type=1&Column=1,2
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@User/ColumnUser.ashx?AccountId=%@&type=%@&Column=%@",_main_url,[Utility sharedUtility].userInfo.ID,number,Column];
    
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            
        }
        self.returnBlock(returnMsg);
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}
@end
