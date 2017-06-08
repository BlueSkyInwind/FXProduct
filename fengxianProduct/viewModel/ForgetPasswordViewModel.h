//
//  ForgetPasswordViewModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/7.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForgetPasswordViewModel : ViewModelClass



/**
 忘记密码
 
 @param number 手机号码
 @param verifyCode 验证码
 @param password 密码
 */
- (void)fatchForgetPasswordMoblieNumber:(NSString *)number verifyCode:(NSString *)verifyCode password:(NSString *)password;



@end
