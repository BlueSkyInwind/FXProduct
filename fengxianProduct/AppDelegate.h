//
//  AppDelegate.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/6.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *appKey = @"2babb39abd26938da3ccd88f";
static NSString *channel = @"App Store";
static BOOL isProduction = NO;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong)BaseTabBarViewController *btb;

extern AppDelegate *app;

@end

