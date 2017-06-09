//
//  UserInfoObj.h
//  fxdProduct
//
//  Created by dd on 15/9/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface UserInfoObj : JSONModel

@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *Images;
@property (nonatomic,strong)NSString *Name;
@property (nonatomic,strong)NSString *Email;
@property (nonatomic,strong)NSString *Mobile;
@property (nonatomic,strong)NSNumber *Gender;
@property (nonatomic,strong)NSString *Address;
@property (nonatomic,strong)NSString *Date;
@property (nonatomic,strong)NSString *Code;
@property (nonatomic,strong)NSString *ColumnNew;     //新闻角标数量
@property (nonatomic,strong)NSString *ColumnLife;      //生活角标数量
@property (nonatomic,strong)NSString *ColumnAct;       //活动角标数量
@property (nonatomic,strong)NSString *Day;


@end
