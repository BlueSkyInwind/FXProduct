//
//  MoreViewModel.h
//  fengxianProduct
//
//  Created by admin on 2017/6/8.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoreViewModel : ViewModelClass

/**
 用户信息获取接口
 */
- (void)obtainAccountInfo;
/**
 用户信息更新接口
 */
- (void)updateAccountInfo:(NSString *)name
                   gender:(NSString *)gender
                    email:(NSString *)email
                   moblie:(NSString *)moblie
                     date:(NSString *)date
                  address:(NSString *)address
                    image:(NSDictionary *)images;

/**
 头像上传

 @param imagedic 数据
 */
-(void)uploadAvatarImage:(NSDictionary *)imagedic;

/**
 获取是否签到，收藏爆料，消息数量的接口
 */
-(void)fatchIsSignAndCollect;

/**
 签到接口
 */
-(void)requestSign;


@end
