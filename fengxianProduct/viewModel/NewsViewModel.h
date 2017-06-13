//
//  NewsViewModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/11.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ViewModelClass.h"

@interface NewsViewModel : ViewModelClass

/**
 获取新闻列表信息

 @param number 栏目id
 @param page 页数
 @param numberOfPage 每页数量
 */
- (void)fatchNewsInfoID:(NSString *)number pageSize:(int)page numberOfPage:(int)numberOfPage;


/**
 获取不同类型的栏目

 @param number 类型的id
 */
- (void)fatchColumnListType:(NSString *)number;


/**
 新闻搜索接口

 @param content 搜索内容
 @param page 页数
 @param numberOfPage 每页内容
 */
- (void)fatchNewsInfoSearchContent:(NSString *)content pageSize:(int)page numberOfPage:(int)numberOfPage;


-(void)fatchWeatherInfo;

@end
