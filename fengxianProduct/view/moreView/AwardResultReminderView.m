//
//  AwardResultReminderView.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/7/2.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "AwardResultReminderView.h"

@implementation AwardResultReminderView
-(void)awakeFromNib{
    [super awakeFromNib];
    

}

- (IBAction)sureBtnClick:(id)sender {
    
    if (self.closeAwardResultView) {
        self.closeAwardResultView(sender);
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
