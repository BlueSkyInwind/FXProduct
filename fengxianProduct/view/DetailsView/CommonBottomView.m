//
//  CommonBottomView.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/20.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "CommonBottomView.h"

@implementation CommonBottomView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.CommentViewIcon.layer.cornerRadius = self.CommentViewIcon.frame.size.width / 2;
    self.CommentViewIcon.clipsToBounds = YES;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(commentViewtap)];
    [self.commentImageView addGestureRecognizer:tap];

}
-(void)commentViewtap{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputCommentTap)]) {
        [self.delegate inputCommentTap];
    }
}

- (IBAction)commentBtnClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(commentButtonClick)]) {
        [self.delegate commentButtonClick];
    }
}
- (IBAction)spotBtnClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(spotButtonClick)]) {
        [self.delegate spotButtonClick];
    }
}
- (IBAction)collectBtnClick:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectButtonClick)]) {
        [self.delegate collectButtonClick];
    }
}
- (IBAction)shareBtnClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareButtonClick)]) {
        [self.delegate shareButtonClick];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
