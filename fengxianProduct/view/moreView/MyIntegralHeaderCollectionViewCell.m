//
//  MyIntegralHeaderCollectionViewCell.m
//  fengxianProduct
//
//  Created by admin on 2017/6/16.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MyIntegralHeaderCollectionViewCell.h"

@implementation MyIntegralHeaderCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     [Tool setCorner:self.integralDetailView borderColor:[UIColor whiteColor] cornerRadius:1];
     [Tool setCorner:self.integralConvertView borderColor:[UIColor whiteColor] cornerRadius:1];
    
    UITapGestureRecognizer * detailTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(integralDetailTap)];
    [self.integralDetailView addGestureRecognizer:detailTap];
    
    UITapGestureRecognizer * convertTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(convertDetailTap)];
    [self.integralConvertView addGestureRecognizer:convertTap];

}

-(void)integralDetailTap{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(integralDetailClick)]) {
        [self.delegate integralDetailClick];
    }

}
-(void)convertDetailTap{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(integralConvertDetailClick)]) {
        [self.delegate integralConvertDetailClick];
    }

}

- (IBAction)backBtnCilck:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(backButtonCilck)]) {
        [self.delegate backButtonCilck];
    }
    
}
- (IBAction)integralBtnClick:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(integralButtonCilck)]) {
        [self.delegate integralButtonCilck];
    }

}



@end
