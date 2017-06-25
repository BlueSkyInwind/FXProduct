//
//  MoreBottomDeleteView.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/25.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MoreBottomDeleteView.h"

@implementation MoreBottomDeleteView

-(void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteViewTap:)];
    [self.tapDeleteView addGestureRecognizer:tap];
}
-(void)deleteViewTap:(UITapGestureRecognizer *)tap{
    if (self.bottomDeleteTap) {
        self.bottomDeleteTap(tap);
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
