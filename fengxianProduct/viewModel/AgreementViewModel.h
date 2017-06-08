//
//  AgreementViewModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/7.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AgreementViewModel : ViewModelClass



/**
 协议，积分说明获取
 
 @param type 1、积分说明 2、关于我们  3、用户注册协议
 */
- (void)fatchRegisterAgreement:(int)type;


@end
