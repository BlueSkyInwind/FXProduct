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
    self.voteProgressiew.layer.cornerRadius = 1;
    self.voteProgressiew.clipsToBounds = YES;
    
}

-(void)setVoteRowsM:(VoteRowsModel *)voteRowsM{
    _voteRowsM = voteRowsM;
    [self layoutIfNeeded];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.titleImageView  sd_setImageWithURL:[NSURL URLWithString:_voteRowsM.Image] placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_1" ]options:SDWebImageRefreshCached];
    self.title.text = [NSString stringWithFormat:@"%@",_voteRowsM.Title];
    self.voteNum.text = [NSString stringWithFormat:@"%@",self.voteNumber];
    float percent = [_voteRowsM.Num floatValue] / [self.voteNumber floatValue];
    self.percentLabel.text = [NSString stringWithFormat:@"%.0f%%",percent * 100];

    self.voteProgressiew.progress = [_voteRowsM.Num floatValue] / [self.voteNumber floatValue];
}
- (IBAction)seletedBtnClick:(id)sender {
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
