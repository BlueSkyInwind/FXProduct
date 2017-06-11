//
//  NewsViewModel.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/11.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "NewsViewModel.h"
#import "NewsListModel.h"
#import "ColumnModel.h"
@implementation NewsViewModel



- (void)fatchNewsInfoID:(NSString *)number pageSize:(int)page numberOfPage:(int)numberOfPage{
    
    //http://infx2.echaokj.cn/ajax/Home/NewList.ashx?ColumnID=1&PageSize=1&PageCount=10http://infx2.echaokj.cn/ajax/Home/NewList.ashx?ColumnID=1&PageSize=1&PageCount=10
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@Home/NewList.ashx?ColumnID=%@&PageSize=%d&PageCount=%d",_main_url,number,page,numberOfPage];
    
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            NewsListModel * newsListModel = [[NewsListModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            self.returnBlock(newsListModel);
        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
    
}


- (void)fatchColumnListType:(NSString *)number{
    
    //http://infx2.echaokj.cn/ajax/Basic/ColumnList.ashx?Type=1&AccountId=0
    NSString * accountID = @"0";
    if ([Utility sharedUtility].loginFlage) {
        accountID = [Utility sharedUtility].userInfo.ID;
    }

    NSString * baseUrl = [NSString stringWithFormat:@"%@Basic/ColumnList.ashx?Type=%@&AccountId=%@",_main_url,number,accountID];
    
    [[FXNetworkManager sharedNetWorkManager]POSTHideIndicatorWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            ColumnModel * columnModel = [[ColumnModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            [Utility sharedUtility].columnModel = columnModel;
            [Tool saveUserDefaul:[object objectForKey:@"result"] Key:FX_ColumnInfo];
            self.returnBlock(columnModel);
        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
    
}

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
