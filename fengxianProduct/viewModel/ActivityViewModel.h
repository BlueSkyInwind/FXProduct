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




@end
