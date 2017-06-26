//
//  MyIntegralListTableViewCell.m
//  fengxianProduct
//
//  Created by admin on 2017/6/26.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MyIntegralListTableViewCell.h"
@implementation MyIntegralListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setIntegralDetailListModel:(IntegralDetailListModel *)integralDetailListModel{
    _integralDetailListModel = integralDetailListModel;
    
    self.timeLabel.text = integralDetailListModel.Time;
    self.titleLabel.text = integralDetailListModel.Title;
    self.integralLabel.text = integralDetailListModel.Integral;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
