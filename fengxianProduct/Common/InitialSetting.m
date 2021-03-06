//
//  InitialSetting.m
//  fengxianProduct
//
//  Created by admin on 2017/6/6.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "InitialSetting.h"
#import "MoreViewModel.h"
#import "ColumnModel.h"
@implementation InitialSetting

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
        // 2.设置网络状态改变后的处理
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            // 当网络状态改变了, 就会调用这个block
            switch (status) {
                case AFNetworkReachabilityStatusUnknown: // 未知网络
                case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                    DLog(@"未知网络 || 没有网络(断网)");
                    [Utility sharedUtility].networkState = NO;
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                    DLog(@"手机自带网络 || WIFI");
                    [Utility sharedUtility].networkState = YES;
                    break;
            }
        }];
        
        // 3.开始监控
        [mgr startMonitoring];
    });
    //获取用户信息
    [Utility sharedUtility].loginFlage = [[Tool getContentWithKey:kLoginFlag] integerValue];
    [Utility sharedUtility].columnModel = [[ColumnModel alloc]initWithDictionary:[Tool getContentWithKey:FX_ColumnInfo] error:nil];

    if ([Tool getContentWithKey:FX_AccountID] && [Utility sharedUtility].loginFlage) {
        
        [Utility sharedUtility].userInfo = [[UserInfoObj alloc]initWithDictionary:[Tool getContentWithKey:FX_AccountID] error:nil];
    }
}





@end
