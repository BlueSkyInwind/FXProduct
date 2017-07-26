//
//  CommentTableViewCell.m
//  fengxianProduct
//
//  Created by admin on 2017/6/19.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "NewsViewModel.h"
@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.secondComentViewHeight.constant = 0;
    self.secondComentView.hidden = YES;
    self.redactReply.hidden = YES;
    self.accoutImage.layer.cornerRadius = self.accoutImage.frame.size.width / 2;
    self.accoutImage.clipsToBounds=  YES;
    self.hotCommentImageView.hidden = YES;
    UITapGestureRecognizer * commentTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(commentTapClick:)];
    [self.commentImageView addGestureRecognizer:commentTap];
    
    UITapGestureRecognizer * spotTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(spotTapClick:)];
    [self.spotImageView addGestureRecognizer:spotTap];
}

-(void)commentTapClick:(UITapGestureRecognizer *)tap{
    if (self.commentEventClick ) {
        self.commentEventClick(tap);
    }
}
-(void)spotTapClick:(UITapGestureRecognizer *)tap{
    [self requestSpot:self.detailCommentModel.ID];
    if (self.spotEventClick ) {
        self.spotEventClick(tap);
    }
}
-(void)requestSpot:(NSString *)commentId{
    NewsViewModel * newViewM = [[NewsViewModel alloc]init];
    [newViewM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            NSString * number = (NSString *)returnMsg.msg;
            self.commentNum.text = [NSString stringWithFormat:@"%@",number];
        }
    } WithFaileBlock:^{
        
    }];
    [newViewM fatchCommentSpotStatus:commentId];
}
-(void)setDetailCommentModel:(DetailCommentModel *)detailCommentModel{
    
    self.secondComentViewHeight.constant = 0;
    self.secondComentView.hidden = YES;
    self.redactReply.hidden = YES;
    _detailCommentModel = detailCommentModel;
    [self setNeedsLayout];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.accoutImage sd_setImageWithURL:[NSURL URLWithString:_detailCommentModel.Images] placeholderImage:[UIImage imageNamed:@"user_Icon"] options:SDWebImageRefreshCached];
    self.accountName.text = _detailCommentModel.Name;
    self.commentTime.text = _detailCommentModel.Time;
    self.accountLabel.text = _detailCommentModel.Conten;
   self.accoutContentHeight.constant =  [Tool heightForText:_detailCommentModel.Conten width:_k_w - 40 font:14] + 20;
    
//    self.commentNum.text = _detailCommentModel.ThumbNum;
//    self.spotNum.text = _detailCommentModel.CommentNum;
    
    self.spotNum.text = [Tool DealWithResult:@([_detailCommentModel.CommentNum intValue])];
    self.commentNum.text = [Tool DealWithResult:@([_detailCommentModel.ThumbNum intValue])];
    self.commentLabelWidth.constant = [Tool widthForText:self.spotNum.text font:10] + 5;
    self.spotLabelWidth.constant = [Tool widthForText:self.commentNum.text font:10] + 5;
    self.commentBackViewWidth.constant = 50 + self.self.commentLabelWidth.constant + self.spotLabelWidth.constant;
    
    if (_detailCommentModel.Reply != nil || [_detailCommentModel.Reply  isEqualToString:@""]) {
        self.redactReply.hidden = NO;
        self.redactReply.text = [NSString stringWithFormat:@"【小编回复】%@",_detailCommentModel.Reply];
        self.redactReplyHeight.constant =  [Tool heightForText:self.redactReply.text width:_k_w - 40 font:14] + 10;
    }else{
        self.redactReply.hidden = YES;
    }
    DetailCommentModel *detailCommentModel2 = [[DetailCommentModel alloc]initWithDictionary:_detailCommentModel.lower error:nil];
    if ([detailCommentModel2.success integerValue] == 1) {
        self.secondComentView.hidden = NO;
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
