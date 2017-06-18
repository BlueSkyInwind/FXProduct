//
//  MyIntegralHeaderCollectionViewCell.h
//  fengxianProduct
//
//  Created by admin on 2017/6/16.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyIntegralHeaderCollectionViewCellDelegate <NSObject>

-(void)backButtonCilck;
-(void)integralButtonCilck;


@end

@interface MyIntegralHeaderCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *integralNumLabel;

@property (weak, nonatomic) IBOutlet UIView *integralDetailView;
@property (weak, nonatomic) IBOutlet UIView *integralConvertView;


@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UIButton *integralBtn;


@property (assign,nonatomic) id<MyIntegralHeaderCollectionViewCellDelegate> delegate;








@end
