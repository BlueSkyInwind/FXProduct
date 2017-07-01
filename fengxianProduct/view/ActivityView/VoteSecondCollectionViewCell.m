//
//  VoteSecondCollectionViewCell.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/28.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "VoteSecondCollectionViewCell.h"

@implementation VoteSecondCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)selectedButtonClick:(id)sender {
    isSelected = !isSelected;
    if (isSelected) {
        [self.seletedButton setImage:[UIImage imageNamed:@"tick_Selected_Icon"] forState:UIControlStateNormal];
    }else{
        [self.seletedButton setImage:[UIImage imageNamed:@"tick_unSelected_Icon"] forState:UIControlStateNormal];
    }
    if (self.votechoose) {
        self.votechoose(isSelected);
    }
}
-(void)setVoteRowsM:(VoteRowsModel *)voteRowsM{
    isSelected = NO;
    _voteRowsM = voteRowsM;
    [self layoutIfNeeded];

}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.titleImageView  sd_setImageWithURL:[NSURL URLWithString:_voteRowsM.Image] placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_1" ]options:SDWebImageRefreshCached];
    self.voteObjectLabel.text = _voteRowsM.Title;
    self.location.text = _voteRowsM.Introduce;
    self.voteNum.text = [NSString stringWithFormat:@"%@", _voteRowsM.Num];
    
}





@end
