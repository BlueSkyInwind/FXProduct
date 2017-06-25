//
//  CommentMessageTableViewCell.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/25.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "CommentMessageTableViewCell.h"

@implementation CommentMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.myCommentView.layer.cornerRadius = 2;
    self.myCommentView.clipsToBounds = YES;
}
- (IBAction)seletedDeleteBtnClick:(id)sender {
    
    isCanDelete = !isCanDelete;
    if (isCanDelete) {
        [self.seletedDeleteBtn setBackgroundImage:[UIImage imageNamed:@"collect_Seleted_Delete"] forState:UIControlStateNormal];
    }else{
        [self.seletedDeleteBtn setBackgroundImage:[UIImage imageNamed:@"collect_unseleted_Delete"] forState:UIControlStateNormal];
    }
    UIButton * button = (UIButton *)sender;
    if (self.selectedBtn) {
        self.selectedBtn(button.tag,isCanDelete);
    }
}
-(void)setCommentMessageDetailModel:(CommentMessageDetailModel *)commentMessageDetailModel{
    _commentMessageDetailModel = commentMessageDetailModel;
    isCanDelete = NO;
    self.timeLabel.text = commentMessageDetailModel.Time;
    self.titleLabel.text = [NSString stringWithFormat:@"%@回复了你：",commentMessageDetailModel.Name];
    self.replayContentLabel.text = commentMessageDetailModel.FConten;
    self.myCommentLabel.text = commentMessageDetailModel.Conten;
    
    if (_isDelete) {
        self.seletedDeleteBtn.hidden = NO;
        self.timeLabelLeftCons.constant = 18;
    }else{
        self.seletedDeleteBtn.hidden = YES;
        self.timeLabelLeftCons.constant = 5;
    }
    if (isCanDelete) {
        [self.seletedDeleteBtn setBackgroundImage:[UIImage imageNamed:@"collect_Seleted_Delete"] forState:UIControlStateNormal];
    }else{
        [self.seletedDeleteBtn setBackgroundImage:[UIImage imageNamed:@"collect_unseleted_Delete"] forState:UIControlStateNormal];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
