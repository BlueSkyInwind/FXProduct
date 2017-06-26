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
#import "DetailModel.h"
#import "PhotoModel.h"
#import "CommentModel.h"
#import "NewsDetailStatusModel.h"

@implementation NewsViewModel


- (void)fatchNewsInfoID:(NSString *)number pageSize:(int)page numberOfPage:(int)numberOfPage{
    
    //http://infx2.echaokj.cn/ajax/Home/NewList.ashx?ColumnID=1&PageSize=1&PageCount=10
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@Home/NewList.ashx?ColumnID=%@&PageSize=%d&PageCount=%d",_main_url,number,page,numberOfPage];
    
    [[FXNetworkManager sharedNetWorkManager]POSTWithNetworkStatusURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
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
- (void)fatchNewsCollectAndSpotStatusID:(NSString *)number type:(NSString *)type{
    
    //http://infx2.echaokj.cn/ajax/inter/UserToSel2.ashx?AccountId=13&NewID=70&type=8
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@inter/UserToSel2.ashx?AccountId=%@&NewID=%@&type=%@",_main_url,[Utility sharedUtility].userInfo.ID,number,type];
    
    [[FXNetworkManager sharedNetWorkManager]POSTWithNetworkStatusURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            NewsDetailStatusModel * newsDetailStatusModel = [[NewsDetailStatusModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            self.returnBlock(newsDetailStatusModel);
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


- (void)fatchNewsInfoSearchContent:(NSString *)content pageSize:(int)page numberOfPage:(int)numberOfPage{
    
    //http://infx2.echaokj.cn/ajax/Home/NewSelect.ashx?Sel=搜索内容&PageSize=1&PageCount=10
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@Home/NewSelect.ashx?Sel=%@&PageSize=%d&PageCount=%d",_main_url,[content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],page,numberOfPage];
    
    [[FXNetworkManager sharedNetWorkManager]POSTWithNetworkStatusURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
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

-(void)fatchWeatherInfo{
    
    //http://i.tianqi.com/index.php?c=code&id=52&icon=1&num=3&py=fengxian
     NSString * baseUrl = @"http://i.tianqi.com/index.php?c=code&id=52&icon=1&num=3&py=fengxian";
    
    [[FXNetworkManager sharedNetWorkManager]GETWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        NSString *  jsonStr = [[NSString alloc] initWithData:object encoding:NSUTF8StringEncoding];

        self.returnBlock(object);
        
    } failure:^(EnumServerStatus status, id object) {
        
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}

- (void)fatchDeatailInfoID:(NSString *)number{
    
    //http://infx2.echaokj.cn/ajax/New/NewDetail.ashx?id=70
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@New/NewDetail.ashx?id=%@",_main_url,number];
    
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            DetailModel * detailModel = [[DetailModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            self.returnBlock(detailModel);
        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}

- (void)fatchPhotoDeatailInfoID:(NSString *)number{
    
    //http://infx2.echaokj.cn/ajax/Life/TakenDetail.ashx?id=2996
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@Life/TakenDetail.ashx?id=%@",_main_url,number];
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            PhotoModel * photoModel = [[PhotoModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            self.returnBlock(photoModel);
        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}


- (void)fatchCollectAndSpotStatus:(NSString *)type ceteID:(NSString *)ceteid{
    
    //http://infx2.echaokj.cn/ajax/inter/UserToApply.ashx?type=0&id=13&cateid=8:1,9:357
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@inter/UserToApply.ashx?type=%@&id=%@&cateid=%@",_main_url,type,[Utility sharedUtility].userInfo.ID,ceteid];
    
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

- (void)uploadComment:(NSString *)commentRank NewID:(NSString *)newID content:(NSString *)content commentType:(NSString *)commentType{
    
     //http://infx2.echaokj.cn/ajax/Home/CommAdd2.ashx?id=1&NewID=1&AccountId=1&type=8&Cont内容&Star=1
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@Home/CommAdd2.ashx?id=%@&NewID=%@&AccountId=%@&type=%@&Cont=%@&Star=1",_main_url,commentRank,newID,[Utility sharedUtility].userInfo.ID,commentType,content];
    NSString *newUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[FXNetworkManager sharedNetWorkManager]POSTWithNetworkStatusURL:newUrl parameters:nil finished:^(EnumServerStatus status, id object) {
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

- (void)fatchCommentSpotStatus:(NSString *)commentID{
    
    //http://infx2.echaokj.cn/ajax/Home/CommThumb.ashx?id=1
    NSString * baseUrl = [NSString stringWithFormat:@"%@Home/CommThumb.ashx?id=%@",_main_url,commentID];
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

- (void)fatchCommentListNewsID:(NSString *)number  ComID:(NSString *)comID  type:(NSString *)type pageSize:(int)page numberOfPage:(int)numberOfPage{
    
    //http://infx2.echaokj.cn/ajax/Home/CommList.ashx?id=3114&type=8&PageSize=1&PageCount=10
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@Home/CommList.ashx?id=%@&ComID=%@&type=%@&PageSize=%d&PageCount=%d",_main_url,number,comID,type,page,numberOfPage];
    
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            CommentModel * commentModel = [[CommentModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            self.returnBlock(commentModel);
        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
    
}

-(void)obatainUserNotice{
   // http://infx2.echaokj.cn/ajax/Basic/NoticeDetail.ashx?AccountId=1914
    NSString * baseUrl = [NSString stringWithFormat:@"%@Basic/NoticeDetail.ashx?AccountId=%@",_main_url,[Utility sharedUtility].userInfo.ID];
    
    [[FXNetworkManager sharedNetWorkManager]POSTHideIndicatorWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
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

-(void)closeUserNotice{
    
    // http://infx2.echaokj.cn/ajax/Basic/NoticeClose.ashx?AccountId=20
    NSString * baseUrl = [NSString stringWithFormat:@"%@Basic/NoticeClose.ashx?AccountId=%@",_main_url,[Utility sharedUtility].userInfo.ID];
    
    [[FXNetworkManager sharedNetWorkManager]POSTHideIndicatorWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            
        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}


@end
