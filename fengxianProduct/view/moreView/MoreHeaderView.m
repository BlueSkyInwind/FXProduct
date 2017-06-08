//
//  MoreHeaderView.m
//  fengxianProduct
//
//  Created by admin on 2017/6/8.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MoreHeaderView.h"

@implementation MoreHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                          action:@selector(goUserInfo:)];
    [self.contentView addGestureRecognizer:tap];
    
}
-(void)configureViewImage:(NSString *)imageUrl AccountID:(NSString *)accountID {
    
    [self.userHeaderImageBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"user_Icon"] options:SDWebImageCacheMemoryOnly];
    
    self.IDLabel.text = [NSString stringWithFormat:@"ID:%@",accountID];
    
}

- (IBAction)qrcodeBtnClick:(id)sender {
    
    if (self.qRCodeBtnClick) {
        self.qRCodeBtnClick(sender);
    }
}

-(void)goUserInfo:(UITapGestureRecognizer *)tap{
    
    if (self.goUserInfoBtnClick) {
        self.goUserInfoBtnClick(tap);
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
