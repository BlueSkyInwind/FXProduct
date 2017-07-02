//
//  MoreNavView.m
//  fengxianProduct
//
//  Created by admin on 2017/6/8.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MoreNavView.h"
#import "MoreViewModel.h"
@implementation MoreNavView

-(void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                          action:@selector(goCollectViewCilck)];
    [self.collectView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                          action:@selector(goDiscloseViewCilck)];
    [self.discloseView addGestureRecognizer:tap2];
    
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                          action:@selector(goEmailViewCilck)];
    [self.emailView addGestureRecognizer:tap3];
    
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                          action:@selector(goSignInViewCilck)];
    [self.signInView addGestureRecognizer:tap4];
    if ([Utility sharedUtility].isSign) {
        
        self.signLabel.text = @"已签到";
    }else{
        self.signLabel.text = @"签到";

    }
    
    self.emailBadgeNum.layer.cornerRadius = self.emailBadgeNum.frame.size.width / 2;
    self.emailBadgeNum.clipsToBounds = YES;
    self.emailBadgeNum.hidden = YES;
}
-(void)goCollectViewCilck{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(CollectViewCilck)]) {
        [self.delegate CollectViewCilck];
    }
}

-(void)goDiscloseViewCilck{
    if (self.delegate && [self.delegate respondsToSelector:@selector(DiscloseViewCilck)]) {
        [self.delegate DiscloseViewCilck];
    }
}
-(void)goEmailViewCilck{
    if (self.delegate && [self.delegate respondsToSelector:@selector(EmailViewCilck)]) {
        [self.delegate EmailViewCilck];
    }
}
-(void)goSignInViewCilck{
    
    if ([[ShareConfig share] isPresentLoginVC:_vc]) {
        if ([Utility sharedUtility].isSign) {
            //        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"今天已签到！"];
            [self userSign];
            
        }else{
            [self userSign];
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(SignInViewCilck)]) {
        [self.delegate SignInViewCilck];
    }
}
-(void)userSign{
    
    MoreViewModel * moreVM = [[MoreViewModel alloc]init];
    [moreVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            self.signLabel.text = @"已签到";
        }
    } WithFaileBlock:^{
        
    }];
    [moreVM requestSign];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
