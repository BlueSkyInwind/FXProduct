//
//  MyFeekbackTableViewCell.m
//  fengxianProduct
//
//  Created by admin on 2017/6/15.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MyFeekbackTableViewCell.h"

@implementation MyFeekbackTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

-(void)setUserCommentModel:(UserCommentModel *)userCommentModel{
    _userCommentModel = nil;
    _userCommentModel = userCommentModel;
    
    self.contentLabel.text = userCommentModel.Text;
    self.timeLabel.text= userCommentModel.Time;
    self.contentLabelHeight.constant = [Tool heightForText:userCommentModel.Text width:_k_w - 10 font:15];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
