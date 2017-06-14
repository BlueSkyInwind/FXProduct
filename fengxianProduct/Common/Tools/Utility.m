//
//  Utility.m
//  fxdProduct
//
//  Created by dd on 15/9/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "Utility.h"

@implementation Utility

@synthesize userInfo;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInfo = [[UserInfoObj alloc] init];
        self.columnModel = [[ColumnModel alloc]init];
        self.isLoadImage = NO;
        
        self.liveListModel = [[NewsListModel alloc]init];
        self.cultureListModel = [[NewsListModel alloc]init];
        self.shootListModel = [[NewsListModel alloc]init];
        self.travelListModel = [[NewsListModel alloc]init];

    }
    return self;
}

+ (Utility *)sharedUtility
{
    static Utility *sharedUtilityInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedUtilityInstance = [[self alloc] init];
    });
    return sharedUtilityInstance;
}



@end
