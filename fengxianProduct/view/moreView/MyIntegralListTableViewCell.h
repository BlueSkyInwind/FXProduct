//
//  MyIntegralListTableViewCell.h
//  fengxianProduct
//
//  Created by admin on 2017/6/26.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntegralDetailModel.h"

@interface MyIntegralListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *integralLabel;


@property (nonatomic,strong)IntegralDetailListModel * integralDetailListModel;



@end
