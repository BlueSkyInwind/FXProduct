//
//  MyAwardListTableViewCell.h
//  fengxianProduct
//
//  Created by admin on 2017/7/3.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAwardListModel.h"
@interface MyAwardListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (nonatomic,strong)MyAwardDetailListModel * myAwardDetailListModel;
@end
