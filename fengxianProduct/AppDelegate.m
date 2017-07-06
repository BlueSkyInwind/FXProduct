//
//  AppDelegate.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/6.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchViewController.h"
#import "LoginViewController.h"
#import "GuideViewController.h"
#import "NotificationModel.h"
#import "CommentDetailViewController.h"
#import "DetailViewController.h"
//#import "InitialSetting.h"
#import "MyMessageViewController.h"
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使 idfa功能所需要引 的头 件(可选)
#import <AdSupport/AdSupport.h>


AppDelegate *app = nil;

@interface AppDelegate ()<JPUSHRegisterDelegate>{

    id currentVC;
    NSDictionary * notificationContentInfo;
    
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    app = self;
    if (!notificationContentInfo) {
        notificationContentInfo = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    LaunchViewController * launchVC = [[LaunchViewController alloc]init];
    self.window.rootViewController = launchVC;
    [self.window makeKeyAndVisible];
    [self monitorNetworkState];
    //shareSDK
    [ShareConfig configDefaultShare];
    //推送
    [self initJPush:launchOptions];
    
    [self performSelector:@selector(enter) withObject:self afterDelay:4];
    
    
    return YES;
}

-(void)enter{
    
    BOOL isFirst = [GuideViewController canShowNewFeature];
    
    if (isFirst && self.guideImageArr) {
        self.window.rootViewController = [GuideViewController newGuideVCWithModels:[_guideImageArr copy] enterBlock:^{
            self.btb = [[BaseTabBarViewController alloc]init];
            self.window.rootViewController = self.btb;
        }];
    } else {
        self.btb = [[BaseTabBarViewController alloc]init];
        self.window.rootViewController = self.btb;
    }
    //通知方法跳转；app在为启动时收到通知，点击启动app处理
    if (notificationContentInfo) {
        [self NotificationJump:notificationContentInfo];
    }
}
-(void)initJPush:(NSDictionary *)launchOptions{
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加 定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];

}

- (void)monitorNetworkState
{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                DLog(@"未知网络 || 没有网络(断网)");
                [Utility sharedUtility].networkState = NO;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                DLog(@"手机自带网络 || WIFI");
                [Utility sharedUtility].networkState = YES;
                break;
        }
    }];
    // 3.开始监控
    [mgr startMonitoring];
}
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的Extras附加字段，key是自己定义的
    
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeNone categories:nil];
    [JPUSHService registerDeviceToken:deviceToken];
    
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    notificationContentInfo = response.notification.request.content.userInfo;
    [self NotificationJump:notificationContentInfo];
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:notificationContentInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    notificationContentInfo= userInfo;
    // Required, iOS 7 Support
    if (application.applicationState == UIApplicationStateActive ){

    }else if(application.applicationState == UIApplicationStateBackground){
        
        [self NotificationJump:userInfo];

    }else if(application.applicationState == UIApplicationStateInactive){
        
    }
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
-(void)NotificationJump:(NSDictionary *)contentInfo{
    
    NotificationModel * notificationM = [[NotificationModel alloc]initWithDictionary:contentInfo error:nil];
    NotificationDetailModel * notificationDetailM =  [[NotificationDetailModel alloc]initWithDictionary:notificationM.extras error:nil];
    currentVC = [[ShareConfig share]topViewController];
    BaseNavigationViewController * BaseNavigationVC;
    if ([currentVC isKindOfClass:[BaseTabBarViewController class]]) {
        BaseTabBarViewController * baseTabVC = currentVC;
        BaseNavigationVC = baseTabVC.selectedViewController;
    }
    if (notificationDetailM) {
        //1:小编回复，跳转对应评论页面；2：礼品兑换通知系统通知跳转我的邮件页面；3新闻推送返回新闻ID用于跳转到对应新闻页面
        if ([notificationDetailM.Type integerValue] == 1) {
            
            CommentDetailViewController * commentDetailVC = [[CommentDetailViewController alloc]init];
            commentDetailVC.detailID = @([notificationDetailM.ComID integerValue]);
            commentDetailVC.comID = notificationDetailM.NewID;
            [BaseNavigationVC pushViewController:commentDetailVC animated:YES];
            
        }else if ([notificationDetailM.Type integerValue] == 2){
            
            MyMessageViewController * myMessageVC= [[MyMessageViewController alloc]init];
            [BaseNavigationVC pushViewController:myMessageVC animated:YES];
            
        }else if ([notificationDetailM.Type integerValue] == 2){
            DetailViewController *detailVC = [[DetailViewController alloc]init];
            detailVC.detailID = @([notificationDetailM.NewID integerValue]);
            detailVC.Species = @(1);
            [BaseNavigationVC pushViewController:detailVC animated:YES];
        }
    }
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[ShareConfig share]updateUserData];
    if (application.applicationIconBadgeNumber>0) {  //badge number 不为0，说明程序有那个圈圈图标
        NSLog(@"我可能收到了推送");
        //这里进行有关处理
        [application setApplicationIconBadgeNumber:0];   //将图标清零。
        //清除激光推送JPush服务器中存储的badge值
        [JPUSHService resetBadge];
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
