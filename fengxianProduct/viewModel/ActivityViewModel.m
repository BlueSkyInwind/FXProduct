//
//  ActivityViewModel.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/25.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ActivityViewModel.h"

@implementation ActivityViewModel


-(void)uploadUserWriteInfo:(NSString *)title content:(NSString *)content type:(NSString *)type imageStr:(NSString *)imageStr MP4:(NSString *)mp4Str{
    
    //http://infx2.echaokj.cn/ajax/My/Contribute.ashx
    NSString * baseUrl = @"http://infx2.echaokj.cn/ajax/My/Contribute.ashx";
    NewsParamModel * model = [[NewsParamModel alloc]init];
    
    model.AccountId = [Utility sharedUtility].userInfo.ID;
    model.Title = title;
    model.Cont = content;
    model.Species = type;
    if (!imageStr) {
        imageStr = @"";
    }
    model.Images = imageStr;
    if (!mp4Str) {
        mp4Str = @"";
    }
    model.Mp4 = mp4Str;
    NSDictionary * dic = [model toDictionary];
    
    [[FXNetworkManager sharedNetWorkManager] POSTWithURL:baseUrl parameters:dic finished:^(EnumServerStatus status, id object) {
        NSString *  jsonStr = [[NSString alloc] initWithData:object encoding:NSUTF8StringEncoding];
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithString:jsonStr error:nil];
        if ([returnMsg.returnCode intValue] != 1) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:(NSString *)returnMsg.msg];
        }
        self.returnBlock(returnMsg);
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}


- (void)fatchVoteInfopageSize:(int)page numberOfPage:(int)numberOfPage{
    
    //http://infx2.echaokj.cn/ajax/Act/ActivityList.ashx?PageSize=1&PageCount=10
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@Act/ActivityList.ashx?PageSize=%d&PageCount=%d",_main_url,page,numberOfPage];
    [[FXNetworkManager sharedNetWorkManager]POSTWithNetworkStatusURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            
            self.returnBlock(returnMsg);
        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}

- (void)fatchAnswerInfopageSize:(int)page numberOfPage:(int)numberOfPage{
    
    //http://infx2.echaokj.cn/ajax/Act/AnswerList.ashx?PageSize=1&PageCount=10
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@Act/AnswerList.ashx?PageSize=%d&PageCount=%D",_main_url,page,numberOfPage];
    [[FXNetworkManager sharedNetWorkManager]POSTWithNetworkStatusURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            
            self.returnBlock(returnMsg);
        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}




@end
