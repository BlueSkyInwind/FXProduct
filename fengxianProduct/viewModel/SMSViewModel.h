//
//  SMSViewModel.h
//  fengxianProduct
//
//  Created by admin on 2017/6/7.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMSViewModel : ViewModelClass

/**
 注册验证码
 
 @param number 手机号
 */
- (void)fatchRegisterVerifyCodeMoblieNumber:(NSString *)number;



@end
