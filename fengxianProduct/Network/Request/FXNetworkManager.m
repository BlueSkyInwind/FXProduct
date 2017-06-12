//
//  FXNetworkManager.m
//  fengxianProduct
//
//  Created by admin on 2017/6/7.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "FXNetworkManager.h"
#import "AFHTTPSessionManager.h"
#import "GTMBase64.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation FXNetworkManager
+ (FXNetworkManager *)sharedNetWorkManager
{
    static FXNetworkManager *sharedNetWorkManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedNetWorkManagerInstance = [[self alloc] init];
    });
    return sharedNetWorkManagerInstance;
}
- (MBProgressHUD *)loadingHUD
{
    MBProgressHUD *_waitView = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    _waitView.mode = MBProgressHUDModeIndeterminate;
    _waitView.dimBackground = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:_waitView];
    return _waitView;
}

- (void)POSTWithURL:(NSString *)strURL parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure
{
     if (![Utility sharedUtility].networkState) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"请确认您的手机是否连接到网络!"];
            return;
        } else {
            MBProgressHUD *_waitView = [self loadingHUD];
            [_waitView show:YES];
            [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
            NSDictionary *paramDic = parameters;
            DLog(@"请求url:---%@\n加密前参数:----%@",strURL,parameters);
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            if (parameters) {
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
                  [manager.requestSerializer setValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];
            }
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/x-www-form-urlencoded",@"application/json",@"charset=UTF-8",@"text/plain", nil];
            manager.requestSerializer.timeoutInterval = 30.0;
            DLog(@"%@",parameters);
            [manager POST:strURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
//                NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
                NSString *jsonStr = @"";
                if ([responseObject isKindOfClass:[NSData class]]) {
                    jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                }else{
                    NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
                    jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                }
                DLog(@"response json --- %@",jsonStr);
                [_waitView removeFromSuperview];
                [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
                finished(Enum_SUCCESS,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [_waitView removeFromSuperview];
                [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
                failure(Enum_FAIL,error);
                [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"服务器请求失败,请重试!"];
                DLog(@"error---%@",error.description);
            }];
        }
}
- (void)POSTHideIndicatorWithURL:(NSString *)strURL parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure
{
    
        NSDictionary *paramDic = [NSDictionary dictionary];
        DLog(@"请求url:---%@\n加密前参数:----%@",strURL,parameters);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
         [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/x-www-form-urlencoded",@"application/json",@"charset=UTF-8",@"text/plain",nil];
        manager.requestSerializer.timeoutInterval = 30.0;
        DLog(@"%@",parameters);
        [manager POST:strURL parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
            NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            DLog(@"response json --- %@",jsonStr);
            finished(Enum_SUCCESS,responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(Enum_FAIL,error);
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"服务器请求失败,请重试!"];
            DLog(@"error---%@",error.description);
        }];
}
-(void)GETWithURL:(NSString *)strURL parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval=31.0f;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:strURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *jsonStr = @"";
        if ([responseObject isKindOfClass:[NSData class]]) {
            jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        }else{
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        finished(Enum_SUCCESS,responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(Enum_FAIL,error);
    }];
}


- (void)POSTUpLoadImage:(NSString *)strURL FilePath:(NSData *)images  parameters:(id)parameters finished:(FinishedBlock)finshed failure:(FailureBlock)failure
{
    if (![Utility sharedUtility].networkState) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"请确认您的手机是否连接到网络!"];
        return;
    } else {
        MBProgressHUD *_waitView = [self loadingHUD];
        [_waitView show:YES];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        DLog(@"请求url:---%@\n 参数:----%@",strURL,parameters);
        
        NSURLSessionConfiguration * sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession * session = [NSURLSession sessionWithConfiguration:sessionConfig];
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request addValue:@"text/html" forHTTPHeaderField:@"Accept"];
        [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Accept"];

        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:images];
        //    NSDictionary * dic = [request allHTTPHeaderFields];
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (response) {
                NSError * responeError;
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:&responeError];
                if (responeError) {
                    //解析失败；
                    NSString *result = [[NSString alloc] initWithData:data
                                                             encoding:NSUTF8StringEncoding];
                    failure(Enum_FAIL,responeError);
                    return ;
                }
                finshed(Enum_SUCCESS,dic);
            }
            
            if (error) {
                failure(Enum_FAIL,error);
            }
        }];
        [postDataTask resume];

    }
}


#pragma mark --- 图片base64编码
- (NSString*)encodeURL:(NSString *)string
{
    NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),kCFStringEncodingUTF8));
    if (newString) {
        return newString;
    }
    return @"";
}

- (UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
}

@end
