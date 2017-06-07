//
//  RegisterViewModel.h
//  fengxianProduct
//
//  Created by admin on 2017/6/7.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterViewModel : ViewModelClass


/**
 注册接口
 
 @param number 手机号
 @param verifyCode 验证码
 @param password 密码
 @param inviteCode 邀请码 （可选）
 */
- (void)fatchRegisterMoblieNumber:(NSString *)number verifyCode:(NSString *)verifyCode password:(NSString *)password inviteCode:(NSString *)inviteCode;

@end
