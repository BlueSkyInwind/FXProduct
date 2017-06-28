//
//  ActivityViewModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/25.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ViewModelClass.h"
#import "NewsParamModel.h"
@interface ActivityViewModel : ViewModelClass



/**
 爆料，新闻上传接口

 @param title 标题
 @param content 内容
 @param type 类型
 @param imageStr 图片
 @param mp4Str 视频
 */
-(void)uploadUserWriteInfo:(NSString *)title content:(NSString *)content type:(NSString *)type imageStr:(NSString *)imageStr MP4:(NSString *)mp4Str;

/**
 投票接口

 @param page 页数
 @param numberOfPage 每页数量
 */
- (void)fatchVoteInfopageSize:(int)page numberOfPage:(int)numberOfPage;

/**
 获取投票详情

 @param ID id
 */
- (void)fatchVoteDetailInfoID:(NSString *)ID;

/**
 新增投票

 @param voteCon 投票内容
 */
-(void)requestAddVote:(NSString *)voteCon;


/**
  问答列表接口

 @param page 页数
 @param numberOfPage 每页数量
 */
- (void)fatchAnswerInfopageSize:(int)page numberOfPage:(int)numberOfPage;


/**
 答题详情

 @param ID ID
 */
- (void)fatchAnswerDEtailInfoID:(NSString *)ID;

/**
 新增答题

 @param ID id
 @param answerCon 内容
 */
- (void)frequestAddAnswerDEtailInfoID:(NSString *)ID answerCon:(NSString *)answerCon;






@end
