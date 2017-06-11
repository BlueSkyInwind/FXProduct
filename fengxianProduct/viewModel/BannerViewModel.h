//
//  BannerViewModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/11.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ViewModelClass.h"

@interface BannerViewModel : ViewModelClass


/**
 获取Banner图

 @param number 类型 1，新闻   2，生活  3，活动
 */
- (void)fatchBannerInfoID:(NSString *)number;

@end
