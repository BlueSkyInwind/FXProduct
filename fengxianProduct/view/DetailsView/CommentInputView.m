//
//  CommentInputView.m
//  fengxianProduct
//
//  Created by admin on 2017/6/20.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "CommentInputView.h"
#import "NewsViewModel.h"
@implementation CommentInputView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [Tool setCorner:self.cancalBtn borderColor:[UIColor clearColor] cornerRadius:2];
    [Tool setCorner:self.sureBtn borderColor:[UIColor clearColor] cornerRadius:3];

    self.contentTextView.layer.cornerRadius = 1;
    self.contentTextView.layer.masksToBounds = YES;
    self.contentTextView.layer.borderWidth = 0.3;
    self.contentTextView.layer.borderColor = kUIColorFromRGB(0x5e5e5e).CGColor;
}
- (IBAction)cancelBtnClick:(id)sender {
    
    if (self.cancelButtonClick) {
        self.cancelButtonClick(sender);
    }
}
- (IBAction)sureBtnClick:(id)sender {
    if (self.sureButtonClick) {
        self.sureButtonClick(sender);
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
