//
//  ChooseView.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/7/1.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseViewDelegate <NSObject>

-(void)chooseButtonClick:(UIButton *)button isSelected:(BOOL)isSelected;

@end

@interface ChooseView : UIView{
    BOOL isSelected;
}
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (assign, nonatomic) BOOL isSingle;
@property (assign, nonatomic) BOOL isSelected;
@property (assign,nonatomic)id<ChooseViewDelegate>delegate;
@end
