//
//  GoodsExchangeView.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/28.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "GoodsExchangeView.h"

@implementation GoodsExchangeView

-(void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer * tap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeTap)];
    [self.closeImageView addGestureRecognizer:tap];
    self.sureBtn.layer.cornerRadius = 2;
    self.sureBtn.clipsToBounds = YES;
    for (UIButton * button in self.typeButton) {
        button.hidden = YES;
    }
}

-(void)closeTap{
    if (self.delegate && [self.delegate respondsToSelector:@selector(closeEventClick)]) {
        [self.delegate closeEventClick];
    }
}

- (IBAction)sureBtnClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sureExchangeClick)]) {
        [self.delegate sureExchangeClick];
    }
}

- (IBAction)typeButtonClick:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(goodsTypeButtonClick:)]) {
        [self.delegate goodsTypeButtonClick:sender];
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
