//
//  Utility.h
//  fxdProduct
//
//  Created by dd on 15/9/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoObj.h"

@interface Utility : NSObject

@property (nonatomic,strong) UserInfoObj *userInfo;
@property (nonatomic,assign) BOOL loginFlage;
@property (nonatomic,assign) BOOL networkState;
@property (nonatomic,assign) BOOL isSign;
@property (nonatomic,assign) BOOL isLoadImage;

+ (Utility *)sharedUtility;

@end
