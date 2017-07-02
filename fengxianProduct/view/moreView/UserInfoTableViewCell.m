//
//  UserInfoTableViewCell.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/8.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "UserInfoTableViewCell.h"

@implementation UserInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentImageView.hidden = YES;
    self.contentImageView.layer.cornerRadius = self.contentImageView.frame.size. height / 2;
    self.contentImageView.clipsToBounds = YES;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
