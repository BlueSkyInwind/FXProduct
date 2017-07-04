//
//  UserQrcodeShareView.m
//  fengxianProduct
//
//  Created by admin on 2017/6/9.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "UserQrcodeShareView.h"
#import "HMScannerController.h"
@implementation UserQrcodeShareView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    NSString * str = self.explainLabel.text;
    NSRange range = [str rangeOfString:@"300"];
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    [attributedString addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:range];
    self.explainLabel.attributedText = attributedString;
    
    self.invationBtn.layer.cornerRadius = self.invationBtn.frame.size. height / 2;
    self.invationBtn.clipsToBounds = YES;
    
    self.userAvatarImage.layer.cornerRadius = self.userAvatarImage.frame.size. height / 2;
    self.userAvatarImage.clipsToBounds = YES;

    self.invationBtnRight.constant = 15;
    if (UI_IS_IPHONE5) {
        self.explainLabelWidth.constant = 170;
    }
    [self configureView];
}
-(void)configureView{
    
    [self.userAvatarImage sd_setImageWithURL:[NSURL URLWithString:[Utility sharedUtility].userInfo.Images] placeholderImage:[UIImage imageNamed:@"user_Icon"] options:SDWebImageRefreshCached];
    self.invationCodeLabel.text = [NSString stringWithFormat:@"邀请码：%@",[Utility sharedUtility].userInfo.Code];
    
    [HMScannerController cardImageWithCardName:[Utility sharedUtility].userInfo.Code avatar:nil scale:0.2 completion:^(UIImage *image) {
        self.qrCodeImage.image = image;
    }];

}

- (IBAction)invationBtnClick:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(invationCodeClick)]) {
        [self.delegate invationCodeClick];
    }
}
- (IBAction)closeBtnClick:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(closeViewClick)]) {
        [self.delegate closeViewClick];
    }
}




@end
