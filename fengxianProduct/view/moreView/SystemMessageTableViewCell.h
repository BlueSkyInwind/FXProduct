//
//  SystemMessageTableViewCell.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/25.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemMessageModel.h"

typedef void (^SelectedBtn)(NSInteger num ,BOOL isCan);

@interface SystemMessageTableViewCell : UITableViewCell{
    BOOL isCanDelete;
    
}

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *seletedDeleteBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelLeftCons;

@property (nonatomic,strong)SystemMessageDetailModel * systemMessageDetailModel;

@property (assign,nonatomic)BOOL isDelete;

@property (copy,nonatomic)SelectedBtn selectedBtn;
@end
