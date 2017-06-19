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
    
    
}

- (IBAction)commentBtnClick:(id)sender {
  
    
}

- (IBAction)spotBtnClick:(id)sender {
  
    
}
- (IBAction)collectBtnClick:(id)sender{
  
    
}
- (IBAction)shareBtnClick:(id)sender {
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
