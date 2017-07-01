//
//  ChooseView.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/7/1.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ChooseView.h"

@implementation ChooseView
-(void)awakeFromNib{
    [super awakeFromNib];
    _isSelected = NO;
    
}

- (IBAction)SelectedButtonClick:(id)sender {
    _isSelected = !_isSelected;
    
    if (_isSingle) {

    }else{
        
    }
  
    UIButton * button = sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseButtonClick:isSelected:)]) {
        [self.delegate chooseButtonClick:button isSelected:_isSelected];
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
