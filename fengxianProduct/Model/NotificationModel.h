//
//  NotificationModel.h
//  fengxianProduct
//
//  Created by admin on 2017/7/6.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol NotificationDetailModel <NSObject>

@end

@interface NotificationDetailModel : JSONModel

@property (nonatomic,strong)NSString<Optional> *NewID;
@property (nonatomic,strong)NSString<Optional> *ComID;
@property (nonatomic,strong)NSString<Optional> *Type;

@end

@interface NotificationModel : JSONModel

@property (nonatomic,strong)NSDictionary<NotificationDetailModel> *extras;
@property (nonatomic,strong)NSString<Optional> *alert;

@end
