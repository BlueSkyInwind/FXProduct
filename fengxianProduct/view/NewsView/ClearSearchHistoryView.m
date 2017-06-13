//
//  ClearSearchHistoryView.m
//  fengxianProduct
//
//  Created by admin on 2017/6/13.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ClearSearchHistoryView.h"

@implementation ClearSearchHistoryView

- (IBAction)deleteBtnClick:(id)sender {
    if (self.deleteSearchHistory) {
        self.deleteSearchHistory(sender);
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
