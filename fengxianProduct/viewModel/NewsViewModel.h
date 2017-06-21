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
 新闻搜索接口

 @param content 搜索内容
 @param page 页数
 @param numberOfPage 每页内容
 */
- (void)fatchNewsInfoSearchContent:(NSString *)content pageSize:(int)page numberOfPage:(int)numberOfPage;


-(void)fatchWeatherInfo;

/**
 详情页接口

 @param number ID
 */
- (void)fatchDeatailInfoID:(NSString *)number;
/**
 图集详情

 @param number ID
 */
- (void)fatchPhotoDeatailInfoID:(NSString *)number;

/**
 收藏点赞，爆料，评论接口

 @param type 类型
 @param ceteid 内容
 */
- (void)fatchCollectAndSpotStatus:(NSString *)type ceteID:(NSString *)ceteid;

/**
 提交评论

 @param commentRank 评论等级
 @param newID 新闻id
 @param content 内容
 @param commentType 评论类型
 */
- (void)uploadComment:(NSString *)commentRank NewID:(NSString *)newID content:(NSString *)content commentType:(NSString *)commentType;
/**
 评论点赞

 @param commentID 评论ID
 */
- (void)fatchCommentSpotStatus:(NSString *)commentID;

/**
 品论列表

 @param number 新闻Id
 @param type 类型
 @param page 页数
 @param numberOfPage 每页个数
 */
- (void)fatchCommentListNewsID:(NSString *)number  type:(NSString *)type pageSize:(int)page numberOfPage:(int)numberOfPage;


@end
