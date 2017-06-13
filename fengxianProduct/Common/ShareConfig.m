//
//  ShareConfig.m
//  fxdProduct
//
//  Created by dd on 2016/12/13.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "ShareConfig.h"
#import "LoginViewController.h"
#import "MoreViewModel.h"
#import "NewsViewModel.h"
#import "ColumnViewModel.h"

@implementation ShareConfig

static ShareConfig * shareConfig = nil;
+(ShareConfig *)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shareConfig = [[ShareConfig alloc]init];
    });
    return shareConfig;
}

-(BOOL)isPresentLoginVC:(UIViewController *)vc{
    
    if ([Utility sharedUtility].loginFlage) {
        return YES;
        
    } else {
        
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先登录！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
//            [alertVC dismissViewControllerAnimated:YES completion:^{
//            }];
            
            LoginViewController *loginView = [LoginViewController new];
            BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginView];
            [vc presentViewController:nav animated:YES completion:nil];
            
        }];
        [alertVC addAction:sureAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
        
        return NO;
    }
}

/**
 输入框弹出

 @param vc vc
 @param placeHolder 默认提示语
 @param userInputContent 用户输入
 */
-(void)presentAlertTextfield:(UIViewController *)vc placeHolder:(NSString *)placeHolder userInputContent:(void(^)(NSString * resultStr))userInputContent{
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"请输入昵称" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField * textField = alertVC.textFields.firstObject;
        userInputContent(textField.text);
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:cancelAction];
    [alertVC addAction:sureAction];
    
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeHolder;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.layer.borderWidth = 1;
        textField.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor yellowColor]);
    }];
    [vc presentViewController:alertVC animated:YES completion:nil];
    
}

-(void)updateUserData{
    
    if (![Utility sharedUtility].loginFlage) {
        return;
    }
    
    //更新用户数据
    MoreViewModel * moreVM = [[MoreViewModel alloc]init];
    [moreVM setBlockWithReturnBlock:^(id returnValue) {
        
    } WithFaileBlock:^{
        
    }];
    [moreVM obtainAccountInfo];
    
}

-(void)obtainNewsColumnInfo{
    
    ColumnViewModel * columnVM = [[ColumnViewModel alloc]init];
    [columnVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        ColumnModel * columnModel = [[ColumnModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
        [Utility sharedUtility].columnModel = columnModel;
        [Tool saveUserDefaul:(NSString *)returnMsg.result Key:FX_ColumnInfo];
    } WithFaileBlock:^{
        
    }];
    [columnVM fatchColumnListType:@"1"];
}
-(void)obtainLivesColumnInfo{
    
    ColumnViewModel * columnVM = [[ColumnViewModel alloc]init];
    [columnVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        ColumnModel * columnModel = [[ColumnModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
        [Utility sharedUtility].livesColumnModel = columnModel;
        [Tool saveUserDefaul:(NSString *)returnMsg.result Key:FX_LivesColumnInfo];
    } WithFaileBlock:^{
        
    }];
    [columnVM fatchColumnListType:@"2"];
}
-(void)obtainActicityColumnInfo{
    
    ColumnViewModel * columnVM = [[ColumnViewModel alloc]init];
    [columnVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        ColumnModel * columnModel = [[ColumnModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
        [Utility sharedUtility].acticityColumnModel = columnModel;
        [Tool saveUserDefaul:(NSString *)returnMsg.result Key:FX_ActivtyColumnInfo];
    } WithFaileBlock:^{
        
    }];
    [columnVM fatchColumnListType:@"3"];
}




+ (void)configDefaultShare
{

    
}

@end
