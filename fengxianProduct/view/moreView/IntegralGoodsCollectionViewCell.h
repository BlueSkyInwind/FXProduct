//
//  IntegralGoodsCollectionViewCell.h
//  fengxianProduct
//
//  Created by admin on 2017/6/16.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegralGoodsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;

@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;

@end
