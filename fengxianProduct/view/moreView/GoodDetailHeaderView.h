//
//  GoodDetailHeaderView.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/27.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodDetailHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *GoodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *GoodsTitle;
@property (weak, nonatomic) IBOutlet UILabel *GoodsNum;
@property (weak, nonatomic) IBOutlet UILabel *GoodsIntegral;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *GoodsTitleHeight;

@end
