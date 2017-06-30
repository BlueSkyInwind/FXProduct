//
//  VoteFirstTableViewCell.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/28.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "VoteFirstTableViewCell.h"

@implementation VoteFirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.voteProgressView.transform = CGAffineTransformMakeScale(1.0f,2.0f);
    self.voteProgressView.layer.cornerRadius = 1;
    self.voteProgressView.clipsToBounds = YES;
}
-(void)setVoteRowsM:(VoteRowsModel *)voteRowsM{
    _voteRowsM = voteRowsM;
    [self layoutIfNeeded];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%ld、%@", (long)self.number,_voteRowsM.Title];
    self.voteNumLabel.text = [NSString stringWithFormat:@"%@/%@",_voteRowsM.Num,self.voteNum];
    self.voteProgressView.progress = [_voteRowsM.Num floatValue] / [self.voteNum floatValue];
}

- (IBAction)selectedBtnCilck:(id)sender {
    
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
