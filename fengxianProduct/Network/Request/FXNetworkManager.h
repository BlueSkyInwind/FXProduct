//
//  FXNetworkManager.h
//  fengxianProduct
//
//  Created by admin on 2017/6/7.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>
//连接状态
typedef enum {
    ///返回数据正确
    Enum_SUCCESS = 0,
    ///返回数据出错
    Enum_FAIL = 1,
    ///连接不上服务器
    Enum_NOTCONNECTED = 2,
    ///超时连接
    Enum_CONNECTEDTIMEOUT = 3
} EnumServerStatus;

typedef void (^FinishedBlock)(EnumServerStatus status, id object);
typedef void (^FailureBlock)(EnumServerStatus status, id object);

@interface FXNetworkManager : NSObject

+ (FXNetworkManager *)sharedNetWorkManager;
- (void)POSTWithURL:(NSString *)strURL parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure;
- (void)POSTHideIndicatorWithURL:(NSString *)strURL parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure;



@end
