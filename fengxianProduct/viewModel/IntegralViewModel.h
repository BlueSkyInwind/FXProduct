//
//  IntegralViewModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/18.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ViewModelClass.h"

@interface IntegralViewModel : ViewModelClass


/**
 获取用户相关积分
 */
- (void)fatchAccountIntegral;

/**
 获取用户积分愁啊几个页面
 */
-(void)requestAwardGoodsInfo;
/**
 抽奖接口
 */
-(void)requestAwardGoodsResult;


/**
 我的奖品的列表视图

 @param type 类型
 @param pageSize 页数
 */
-(void)fatchUserAwardListInfo:(NSString *)type pageSize:(int)pageSize;


@end
