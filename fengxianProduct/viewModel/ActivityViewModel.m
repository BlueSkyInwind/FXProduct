//
//  ActivityViewModel.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/25.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ActivityViewModel.h"
#import "VoteListModel.h"
#import "AnswerListModel.h"
#import "VoteDetailModel.h"

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
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            NewsListModel * newsListM = [[NewsListModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            self.returnBlock(newsListM);
        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}
- (void)fatchVoteDetailInfoID:(NSString *)ID {
    
    
    //http://infx2.echaokj.cn/ajax/Act/VoteList.ashx?Id=4&AccountId=20
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@Act/VoteList.ashx?Id=%@&AccountId=%@",_main_url,ID,[Utility sharedUtility].userInfo.ID];
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            VoteDetailModel * voteDetailM = [[VoteDetailModel alloc] initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            self.returnBlock(voteDetailM);
        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}

-(void)requestAddVote:(NSString *)voteCon{
    
    //http://infx2.echaokj.cn/ajax/Act/VoteAdd.ashx?Vote=4,5&AccountId=20
    NSString * baseUrl = [NSString stringWithFormat:@"%@Act/VoteAdd.ashx?Vote=%@&AccountId=%@",_main_url,voteCon,[Utility sharedUtility].userInfo.ID];
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
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
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            NewsListModel * newsListM = [[NewsListModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            self.returnBlock(newsListM);
        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}


- (void)fatchAnswerDEtailInfoID:(NSString *)ID{
    
    //http://infx2.echaokj.cn/ajax/Surrvey/SurrveyDetail.ashx?id=4&AccountId=20
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@Surrvey/SurrveyDetail.ashx?id=%@&AccountId=%@",_main_url,ID,[Utility sharedUtility].userInfo.ID];
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
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

- (void)frequestAddAnswerDEtailInfoID:(NSString *)ID answerCon:(NSString *)answerCon{
    
    //http://infx2.echaokj.cn/ajax/Surrvey/SurrveyToUser.ashx?id=1&Answer=填空内容;4;0:1:3&AccountId=20
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@Surrvey/SurrveyToUser.ashx?id=%@&Answer=%@&AccountId=%@",_main_url,ID,answerCon,[Utility sharedUtility].userInfo.ID];
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
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
