//
//  SingleChooseTableViewCell.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/7/1.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnswerDetailModel.h"
#import "ChooseView.h"

typedef void (^SingleChoose)(NSString * resultSTr,BOOL isDelete,NSInteger num);
@interface SingleChooseTableViewCell : UITableViewCell<ChooseViewDelegate>{
    NSMutableArray * contentArr;
    
    NSMutableArray * contentheightArr;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelHeight;
@property (nonatomic,strong)AnswerRowsModel * answerRowsModel;
@property (assign,nonatomic)NSInteger number;
@property (copy,nonatomic)SingleChoose singleChoose;


@end
