//
//  NoticeView.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/27.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "NoticeView.h"
#import "NewsViewModel.h"
@implementation NoticeView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.scrollLabel.marqueeType = MLContinuous;
    self.scrollLabel.textAlignment = NSTextAlignmentRight;
    self.scrollLabel.lineBreakMode = NSLineBreakByTruncatingHead;
    self.scrollLabel.scrollDuration = 15.0;
    self.scrollLabel.fadeLength = 15.0f;
    self.scrollLabel.leadingBuffer = 40.0f;
    
}



- (IBAction)closeNoticeViewClick:(id)sender {
    
    NewsViewModel * newsViewModel = [[NewsViewModel alloc]init];
    [newsViewModel closeUserNotice];
    if (self.closeNoticeView) {
        self.closeNoticeView(sender);
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
