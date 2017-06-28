//
//  GoodsExchangeView.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/28.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodsExchangeViewDelegate <NSObject>

-(void)closeEventClick;
-(void)goodsTypeButtonClick:(UIButton *)button;
-(void)sureExchangeClick;

@end


@interface GoodsExchangeView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *closeImageView;

@property (weak, nonatomic) IBOutlet UILabel *goodTitle;

@property (weak, nonatomic) IBOutlet UILabel *goodIntegral;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *typeButton;

@property (assign,nonatomic)id<GoodsExchangeViewDelegate> delegate;

@end
