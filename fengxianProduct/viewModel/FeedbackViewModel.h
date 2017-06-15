//
//  FeedbackViewModel.h
//  fengxianProduct
//
//  Created by admin on 2017/6/15.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ViewModelClass.h"

@interface FeedbackViewModel : ViewModelClass


/**
 用户反馈信息

 @param content 内容
 @param mageURl 图片路径
 @param userNumber 用户联系方式
 */
- (void)uploadAccountFeedfackInfo:(NSString *)content
                         imageURl:(NSString *)mageURl
                       userNumber:(NSString *)userNumber;

@end
