//
//  IntegralViewModel.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/18.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "IntegralViewModel.h"
#import "integralModel.h"
#import "AwardModel.h"
#import "AwardResultModel.h"
#import "MyAwardListModel.h"

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

-(void)requestAwardGoodsInfo{
    
    //http://infx2.echaokj.cn/ajax/Basic/LuckyList.ashx?AccountId=13
    NSString * baseUrl = [NSString stringWithFormat:@"%@Basic/LuckyList.ashx?AccountId=%@",_main_url,[Utility sharedUtility].userInfo.ID];
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            AwardModel * awardModel = [[AwardModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            self.returnBlock(awardModel);

        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}


-(void)requestAwardGoodsResult{
    
    //http://infx2.echaokj.cn/ajax/inter/UserLucky.ashx?AccountId=13
    NSString * baseUrl = [NSString stringWithFormat:@"%@inter/UserLucky.ashx?AccountId=%@",_main_url,[Utility sharedUtility].userInfo.ID];
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            AwardResultModel * awardResultM = [[AwardResultModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
        }
        self.returnBlock(returnMsg);
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}

-(void)fatchUserAwardListInfo:(NSString *)type pageSize:(int)pageSize{
    
    //http://infx2.echaokj.cn/ajax/My/CommentType.ashx?type=0&AccountId=6&PageSize=1
    NSString * baseUrl = [NSString stringWithFormat:@"%@My/CommentType.ashx?type=%@&AccountId=%@&PageSize=%d",_main_url,type,[Utility sharedUtility].userInfo.ID,pageSize];
    [[FXNetworkManager sharedNetWorkManager]POSTHideIndicatorWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            MyAwardListModel * myAwardListModel = [[MyAwardListModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            self.returnBlock(myAwardListModel);
        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}



@end
