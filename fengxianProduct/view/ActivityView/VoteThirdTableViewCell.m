//
//  VoteThirdTableViewCell.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/28.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "VoteThirdTableViewCell.h"

@implementation VoteThirdTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.voteProgressiew.transform = CGAffineTransformMakeScale(1.0f,2.0f);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
