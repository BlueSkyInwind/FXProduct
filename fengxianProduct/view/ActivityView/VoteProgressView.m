//
//  VoteProgressView.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/7/1.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "VoteProgressView.h"

@implementation VoteProgressView
-(void)awakeFromNib{
    [super awakeFromNib];
    self.progressView.transform = CGAffineTransformMakeScale(1.0f,2.0f);
    self.progressView.layer.cornerRadius = 1;
    self.progressView.clipsToBounds = YES;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
