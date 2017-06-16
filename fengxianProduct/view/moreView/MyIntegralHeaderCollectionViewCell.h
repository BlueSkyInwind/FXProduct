//
//  MyIntegralHeaderCollectionViewCell.h
//  fengxianProduct
//
//  Created by admin on 2017/6/16.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MyIntegralHeaderCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *integralNumLabel;

@property (weak, nonatomic) IBOutlet UIView *integralDetailView;
@property (weak, nonatomic) IBOutlet UIView *integralConvertView;

@end
