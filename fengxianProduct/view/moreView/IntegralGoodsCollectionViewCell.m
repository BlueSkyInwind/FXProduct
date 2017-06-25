//
//  IntegralGoodsCollectionViewCell.m
//  fengxianProduct
//
//  Created by admin on 2017/6/16.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "IntegralGoodsCollectionViewCell.h"

@implementation IntegralGoodsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

-(void)setIntegralGoodsM:(integralGoodsModel *)integralGoodsM{
    _integralGoodsM = integralGoodsM;
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:integralGoodsM.Image] placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_1"] options:SDWebImageRefreshCached];
    self.goodsTitleLabel.text = integralGoodsM.Title;
    self.goodsPrice.text = [NSString stringWithFormat:@"%@积分",integralGoodsM.Integral];
    self.goodsNumLabel.text = [NSString stringWithFormat:@"剩余%@",integralGoodsM.Num];
    
}

@end
