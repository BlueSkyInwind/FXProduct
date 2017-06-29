//
//  ShareConfig.h
//  fxdProduct
//
//  Created by dd on 2016/12/13.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareConfig : NSObject


+(ShareConfig *)share;
-(BOOL)isPresentLoginVC:(UIViewController *)vc;
-(void)updateUserData;
/**
 输入框弹出
 
 @param vc vc
 @param placeHolder 默认提示语
 @param userInputContent 用户输入
 */
-(void)presentAlertTextfield:(UIViewController *)vc title:(NSString *)title placeHolder:(NSString *)placeHolder userInputContent:(void(^)(NSString * resultStr))userInputContent;

/**
 弹出框
 
 @param title 标题
 @param content 内容
 @param vc 当前视图
 @param sureClick 确定
 @param cancelClick 取消
 */
-(void)presentAlertTitle:(NSString *)title content:(NSString *)content VC:(UIViewController *)vc sureClick:(void(^)(NSString * resultStr))sureClick cancelClick:(void(^)(NSString * resultStr))cancelClick;

- (UIViewController *)topViewController;

+ (void)configDefaultShare;

-(void)obtainNewsColumnInfo;
-(void)obtainLivesColumnInfo;
-(void)obtainActicityColumnInfo;


@end
