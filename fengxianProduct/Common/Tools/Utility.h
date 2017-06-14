//
//  Utility.h
//  fxdProduct
//
//  Created by dd on 15/9/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoObj.h"
#import "ColumnModel.h"
@interface Utility : NSObject


@property (nonatomic,strong) UserInfoObj *userInfo;
@property (nonatomic,assign) BOOL loginFlage;
@property (nonatomic,assign) BOOL networkState;
@property (nonatomic,assign) BOOL isSign;
@property (nonatomic,assign) BOOL isLoadImage;
@property (nonatomic,strong) ColumnModel *columnModel;
@property (nonatomic,strong) ColumnModel *livesColumnModel;
@property (nonatomic,strong) ColumnModel *acticityColumnModel;

+ (Utility *)sharedUtility;

@end
