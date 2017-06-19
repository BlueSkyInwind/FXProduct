//
//  CommentTableViewCell.m
//  fengxianProduct
//
//  Created by admin on 2017/6/19.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.secondComentViewHeight.constant = 0;
    self.secondComentView.hidden = YES;
    self.redactReply.hidden = YES;
    self.accoutImage.layer.cornerRadius = self.accoutImage.frame.size.width / 2;
    self.accoutImage.clipsToBounds=  YES;
    UITapGestureRecognizer * commentTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(commentTapClick)];
    [self.commentImageView addGestureRecognizer:commentTap];
    
    UITapGestureRecognizer * spotTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(spotTapClick)];
    [self.spotImageView addGestureRecognizer:spotTap];
}
-(void)commentTapClick{
    
    
    
    
}
-(void)spotTapClick{
    
    
    
}
-(void)setDetailCommentModel:(DetailCommentModel *)detailCommentModel{
    _detailCommentModel = detailCommentModel;
    [self setNeedsLayout];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.accoutImage sd_setImageWithURL:[NSURL URLWithString:_detailCommentModel.Images] placeholderImage:[UIImage imageNamed:@"user_Icon"] options:SDWebImageRefreshCached];
    self.accountName.text = _detailCommentModel.Name;
    self.commentTime.text = _detailCommentModel.Time;
    self.accountLabel.text = _detailCommentModel.Conten;
   self.accoutContentHeight.constant =  [Tool heightForText:_detailCommentModel.Conten width:self.accountLabel.frame.size.width font:14];
    self.commentNum.text = _detailCommentModel.ThumbNum;
    self.spotNum.text = _detailCommentModel.CommentNum;
    if (_detailCommentModel.Reply != nil || [_detailCommentModel.Reply  isEqualToString:@""]) {
        self.redactReply.hidden = NO;
        self.redactReply.text = [NSString stringWithFormat:@"【小编回复】%@",_detailCommentModel.Reply];
        self.redactReplyHeight.constant =  [Tool heightForText:_detailCommentModel.Reply width:self.redactReply.frame.size.width font:14];
    }else{
        self.redactReply.hidden = YES;
    }
    DetailCommentModel *detailCommentModel2 = [[DetailCommentModel alloc]initWithDictionary:_detailCommentModel.lower error:nil];
    if ([detailCommentModel2.success integerValue] == 1) {
        self.secondComentViewHeight.constant = 85;
        self.secondName.text = detailCommentModel2.Name;
        self.secondTime.text = detailCommentModel2.Time;
        self.secondContent.text = detailCommentModel2.Conten;
    }else{
        self.secondComentViewHeight.constant = 0;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
