//
//  GapFillingTableViewCell.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/7/1.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnswerDetailModel.h"
typedef void (^ContentResultStr)(NSString * resultStr,NSInteger num);
@interface GapFillingTableViewCell : UITableViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contenttextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelHeightCons;

@property (nonatomic,strong)AnswerRowsModel * answerRowsModel;
@property (assign,nonatomic)NSInteger number;
@property (copy,nonatomic)ContentResultStr contentResultStr;


@end
