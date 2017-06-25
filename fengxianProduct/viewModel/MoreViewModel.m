//
//  MoreViewModel.m
//  fengxianProduct
//
//  Created by admin on 2017/6/8.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MoreViewModel.h"
#import "SignAndCollectMdoel.h"
#import "NSString+URL.h"
#import "userSourceModel.h"
#import "UserCommentModel.h"
#import "CollectModel.h"
#import "BrokeModel.h"
#import "SystemMessageModel.h"
#import "CommentMessageModel.h"
@implementation MoreViewModel

/**
 用户信息获取接口
 */
- (void)obtainAccountInfo{
    
     //http://infx2.echaokj.cn/ajax/inter/UserQuery.ashx?AccountId=10
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@inter/UserQuery.ashx?AccountId=%@",_main_url,[Utility sharedUtility].userInfo.ID];
    
    [[FXNetworkManager sharedNetWorkManager]POSTHideIndicatorWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
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
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}

- (void)updateAccountInfo:(NSString *)name
                   gender:(NSString *)gender
                    email:(NSString *)email
                   moblie:(NSString *)moblie
                   date:(NSString *)date
                    address:(NSString *)address
                    image:(NSString *)images{
    
    //http://infx2.echaokj.cn/ajax/inter/UserDetail.ashx?AccountId=1&Name=好可爱的人&Images=XX.png&Gender=1&Email=1111@qq.com&Mobile=18321587571&Date=2014-4-12&Address=浦东新区
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@inter/UserDetail.ashx?AccountId=%@&Name=%@&Images=%@&Gender=%@&Email=%@&Mobile=%@&Date=%@&Address=%@",_main_url,[Utility sharedUtility].userInfo.ID,name,images,gender,email,moblie,date,address];
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

-(void)uploadAvatarImage:(NSDictionary *)imagedic{
    
    //http://infx2.echaokj.cn/ajax/My/Upload.ashx
    NSString * baseUrl = @"http://infx2.echaokj.cn/ajax/My/Upload.ashx";
    NSString * imageDataStr = [[imagedic allValues].firstObject base64EncodedStringWithOptions:0];
    NSString * type = [imagedic allKeys].firstObject;
    NSString *imageStr = [imageDataStr URLEncodedString];
    userSourceModel * userSource = [[userSourceModel alloc]init];
    userSource.File = imageDataStr;
    userSource.format = type;
    NSDictionary * dic = [userSource toDictionary];

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

-(void)fatchIsSignAndCollect{
    
    //http://infx2.echaokj.cn/ajax/inter/MyInformation.ashx?AccountId=20
    NSString * baseUrl = [NSString stringWithFormat:@"%@inter/MyInformation.ashx?AccountId=%@",_main_url,[Utility sharedUtility].userInfo.ID];
    
    [[FXNetworkManager sharedNetWorkManager]POSTHideIndicatorWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            DLog(@"获取成功");
            SignAndCollectMdoel * signModel = [[SignAndCollectMdoel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            [Utility sharedUtility].isSign = signModel.Sign;
            
        }else{
            
        }
        self.returnBlock(returnMsg);
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}
-(void)requestSign{
    
    //http://infx2.echaokj.cn/ajax/inter/SignIn.ashx?AccountId=6
    NSString * baseUrl = [NSString stringWithFormat:@"%@inter/SignIn.ashx?AccountId=%@",_main_url,[Utility sharedUtility].userInfo.ID];
    
    [[FXNetworkManager sharedNetWorkManager]POSTHideIndicatorWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            DLog(@"获取成功");
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:[NSString stringWithFormat:@"连续签到%@天",returnMsg.msg]];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:(NSString *)returnMsg.msg];
        }
        self.returnBlock(returnMsg);
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}

-(void)fatchAboutUserMoreInfo:(NSString *)type pageSize:(int)pageSize{
    
    //http://infx2.echaokj.cn/ajax/My/CommentType.ashx?type=0&AccountId=6&PageSize=1
    NSString * baseUrl = [NSString stringWithFormat:@"%@My/CommentType.ashx?type=%@&AccountId=%@&PageSize=%d",_main_url,type,[Utility sharedUtility].userInfo.ID,pageSize];
    
    [[FXNetworkManager sharedNetWorkManager]POSTHideIndicatorWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            UserCommentListModel * userCommentLisModel = [[UserCommentListModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            self.returnBlock(userCommentLisModel);
        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}

-(void)fatchUserCollectInfo:(NSString *)type pageSize:(int)pageSize{
    
    //http://infx2.echaokj.cn/ajax/My/CommentType.ashx?type=0&AccountId=6&PageSize=1
    NSString * baseUrl = [NSString stringWithFormat:@"%@My/CommentType.ashx?type=%@&AccountId=%@&PageSize=%d",_main_url,type,[Utility sharedUtility].userInfo.ID,pageSize];
    
    [[FXNetworkManager sharedNetWorkManager]POSTHideIndicatorWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            CollectModel * collectModel = [[CollectModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            self.returnBlock(collectModel);
        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}

-(void)fatchUserBrokeInfoPageSize:(int)pageSize{
    
    //http://infx2.echaokj.cn/ajax/My/MyReport.ashx?Species=&AccountId=6&PageSize=1
    NSString * baseUrl = [NSString stringWithFormat:@"%@My/MyReport.ashx?Species=&AccountId=%@&PageSize=%d",_main_url,[Utility sharedUtility].userInfo.ID,pageSize];
    
    [[FXNetworkManager sharedNetWorkManager]POSTHideIndicatorWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            BrokeModel * brokeModel = [[BrokeModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            self.returnBlock(brokeModel);
        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}


-(void)fatchUserMessageInfo:(NSString *)type pageSize:(int)pageSize{
    
    //http://infx2.echaokj.cn/ajax/My/CommentType.ashx?type=0&AccountId=6&PageSize=1
    NSString * baseUrl = [NSString stringWithFormat:@"%@My/CommentType.ashx?type=%@&AccountId=%@&PageSize=%d",_main_url,type,[Utility sharedUtility].userInfo.ID,pageSize];
    
    [[FXNetworkManager sharedNetWorkManager]POSTHideIndicatorWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            SystemMessageModel * systemMessageModel = [[SystemMessageModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            self.returnBlock(systemMessageModel);
        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}

-(void)fatchUserCommentMessageInfo:(NSString *)type pageSize:(int)pageSize{
    
    //http://infx2.echaokj.cn/ajax/My/CommentType.ashx?type=0&AccountId=6&PageSize=1
    NSString * baseUrl = [NSString stringWithFormat:@"%@My/CommentType.ashx?type=%@&AccountId=%@&PageSize=%d",_main_url,type,[Utility sharedUtility].userInfo.ID,pageSize];
    
    [[FXNetworkManager sharedNetWorkManager]POSTHideIndicatorWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            CommentMessageModel * commentMessageModel = [[CommentMessageModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            self.returnBlock(commentMessageModel);
        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}


@end
