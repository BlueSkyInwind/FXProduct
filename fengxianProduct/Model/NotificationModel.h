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
//@property (nonatomic,strong)NSString<Optional> *alert;
//@property (nonatomic,strong)NSString<Optional> *badge;
//@property (nonatomic,strong)NSString<Optional> *sound;

@end
////  {"extras":{"Type":2},"alert":"【礼品兑换通知】更多积分兑换商品，敬请期待！！"}}

@interface NotificationModel : JSONModel

//@property (nonatomic,strong)NSDictionary * aps;
//@property (nonatomic,strong)NSString<Optional> * _j_msgid;

@property (nonatomic,strong)NSDictionary * extras;
@property (nonatomic,strong)NSString<Optional> *alert;


@end
