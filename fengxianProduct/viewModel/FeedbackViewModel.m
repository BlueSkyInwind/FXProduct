//
//  FeedbackViewModel.m
//  fengxianProduct
//
//  Created by admin on 2017/6/15.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "FeedbackViewModel.h"

@implementation FeedbackViewModel


//
- (void)uploadAccountFeedfackInfo:(NSString *)content
                   imageURl:(NSString *)mageURl
                    userNumber:(NSString *)userNumber{
    
    //http://infx2.echaokj.cn/ajax/User/UserToOponopn.ashx?AccountId=20&Text=反馈内容&Images=&Contact=18321587571
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@User/UserToOponopn.ashx?AccountId=%@&Text=%@&Images=%@&Contact=%@",_main_url,[Utility sharedUtility].userInfo.ID,content,mageURl,userNumber];
    NSString *newUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:newUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] != 1) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:returnMsg.msg];
        }
        self.returnBlock(returnMsg);
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
        
    }];
}



@end
