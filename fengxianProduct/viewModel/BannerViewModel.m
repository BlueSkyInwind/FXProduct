//
//  BannerViewModel.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/11.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "BannerViewModel.h"
#import "BannerInfoModel.h"
@implementation BannerViewModel


- (void)fatchBannerInfoID:(NSString *)number{
    
    //http://infx2.echaokj.cn/ajax/Home/NewBannerList.ashx?id=1
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@Home/NewBannerList.ashx?id=%@",_main_url,number];
    
    [[FXNetworkManager sharedNetWorkManager]POSTWithURL:baseUrl parameters:nil finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass * returnMsg = [[ReturnMsgBaseClass alloc]initWithDictionary:object error:nil];
        if ([returnMsg.returnCode intValue] == 1) {
            BannerListModel * bannerList = [[BannerListModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            self.returnBlock(bannerList);
        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:error.description];
        [self faileBlock];
    }];
}




@end
