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


+ (void)configDefaultShare;

-(void)obtainNewsColumnInfo;
-(void)obtainLivesColumnInfo;
-(void)obtainActicityColumnInfo;


@end
