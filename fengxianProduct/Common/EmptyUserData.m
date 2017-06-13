//
//  EmptyUserData.m
//  fxdProduct
//
//  Created by dd on 2016/11/28.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "EmptyUserData.h"
#import "DataWriteAndRead.h"

@implementation EmptyUserData

+ (void)EmptyData
{
    
    [Utility sharedUtility].userInfo = nil;
    [Utility sharedUtility].columnModel = nil;
    [Utility sharedUtility].loginFlage = NO;
    [Utility sharedUtility].isSign = NO;
    [Utility sharedUtility].isLoadImage = NO;
    [Tool saveUserDefaul:@"0" Key:kLoginFlag];
    [Tool saveUserDefaul:@"0" Key:kLoginFlag];
    [Tool saveUserDefaul:nil Key:FX_AccountID];
    [Tool saveUserDefaul:nil Key:FX_ColumnInfo];
    [DataWriteAndRead removeDataWithKey:FX_SearchHistory];
}

@end
