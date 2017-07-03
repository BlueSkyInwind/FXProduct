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
                    image:(NSString *)images;

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

/**
 获取用户更多中的信息

 @param type 类型
 @param pageSize 页数
 */
-(void)fatchAboutUserMoreInfo:(NSString *)type pageSize:(int)pageSize;

/**
 获取用户收藏信息

 @param type 类型
 @param pageSize 页数
 */
-(void)fatchUserCollectInfo:(NSString *)type pageSize:(int)pageSize;
/**
 获取用户的爆料信息

 @param pageSize 页数
 */
-(void)fatchUserBrokeInfoPageSize:(int)pageSize;

/**
 获取用户的系统消息

 @param type 类型
 @param pageSize 页数
 */
-(void)fatchUserMessageInfo:(NSString *)type pageSize:(int)pageSize;
/**
 获取评论消息

 @param type 类型
 @param pageSize 页数
 */
-(void)fatchUserCommentMessageInfo:(NSString *)type pageSize:(int)pageSize;

/**
 我的积分详情

 @param type 类型
 @param pageSize 页数
 */
-(void)fatchUserIntegralDetailInfo:(NSString *)type pageSize:(int)pageSize;
/**
 我的兑换记录

 @param type 类型
 @param pageSize    页数
 */
-(void)fatchUserExchangeIntegralInfo:(NSString *)type pageSize:(int)pageSize;

/**
 商品详情页

 @param goodsId 商品id
 */
-(void)fatchGoodsDetailInfo:(NSString *)goodsId;
/**
 用户商品兑换

 @param goodsId 产品型号样式ID
 @param address  地址
 */
-(void)exchangeGoodsTypeId:(NSString *)goodsId address:(NSString *)address;



@end
