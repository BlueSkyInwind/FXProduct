//
//  ReturnMsgBaseClass.h
//  fengxianProduct
//
//  Created by admin on 2017/6/7.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReturnMsgBaseClass : JSONModel

@property (nonatomic,strong)NSNumber * returnCode;
@property(nonatomic,strong)id<Optional> result;
@property(nonatomic,strong)id<Optional> msg;


@end