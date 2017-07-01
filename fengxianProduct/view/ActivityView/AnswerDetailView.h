//
//  AnswerDetailView.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/7/1.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnswerDetailModel.h"

typedef void(^RequestAnswerStatus)(BOOL isSuccess);
@interface AnswerDetailView : UIView

@property (nonatomic,strong)NSString * answerID;

@property (nonatomic,strong)AnswerDetailModel *answerDetailModel;
@property (nonatomic,copy)RequestAnswerStatus requestAnswerStatus;

@end
