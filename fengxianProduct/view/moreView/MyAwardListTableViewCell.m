//
//  MyAwardListTableViewCell.m
//  fengxianProduct
//
//  Created by admin on 2017/7/3.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MyAwardListTableViewCell.h"

@implementation MyAwardListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setMyAwardDetailListModel:(MyAwardDetailListModel *)myAwardDetailListModel{
    
    _myAwardDetailListModel = myAwardDetailListModel;
    [self layoutIfNeeded];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.text = _myAwardDetailListModel.Title;
    self.timeLabel.text = _myAwardDetailListModel.Time;
    
    
    if ([_myAwardDetailListModel.States intValue] == 0) {
        self.statusLabel.text = @"未兑换";
    }else{
        self.statusLabel.text = @"已兑换";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
