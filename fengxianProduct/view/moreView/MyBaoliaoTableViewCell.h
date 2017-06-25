//
//  MyBaoliaoTableViewCell.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/25.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrokeModel.h"
typedef void (^SelectedBtn)(NSInteger num ,BOOL isCan);

@interface MyBaoliaoTableViewCell : UITableViewCell{
    BOOL isCanDelete;

}

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *SeletedDeleteBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusLabelLeftCons;

@property (nonatomic,strong)BrokeDetailModel * brokeDetailModel;

@property (assign,nonatomic)BOOL isDelete;

@property (copy,nonatomic)SelectedBtn selectedBtn;

@end
