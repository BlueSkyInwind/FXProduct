//
//  ActivityBrokeViewTableViewCell.m
//  fengxianProduct
//
//  Created by admin on 2017/6/15.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ActivityBrokeViewTableViewCell.h"

@implementation ActivityBrokeViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.baoliaoBtn.layer.cornerRadius = 3;
    self.baoliaoBtn.clipsToBounds = YES;
    self.contributeBtn.layer.cornerRadius = 3;
    self.contributeBtn.clipsToBounds = YES;
    
    isBaoliao = NO;
    isContribute = NO;
}

- (IBAction)baoliaoBtnClick:(id)sender {
    isBaoliao = !isBaoliao;
    if (isContribute) {
        isContribute = !isContribute;
        [self.contributeBtn setBackgroundColor:kUIColorFromRGB(0x5e5e5e)];
    }
    if (isBaoliao) {
        [self.baoliaoBtn setBackgroundColor:UI_MAIN_COLOR];
    }else{
        [self.baoliaoBtn setBackgroundColor:kUIColorFromRGB(0x5e5e5e)];
    }
    
    

}
- (IBAction)contributeBtnClick:(id)sender {
    
    isContribute = !isContribute;
    if (isBaoliao) {
        isBaoliao = !isBaoliao;
        [self.baoliaoBtn setBackgroundColor:kUIColorFromRGB(0x5e5e5e)];
    }
    if (isContribute) {
        [self.contributeBtn setBackgroundColor:UI_MAIN_COLOR];
    }else{
        [self.contributeBtn setBackgroundColor:kUIColorFromRGB(0x5e5e5e)];
    }
    
    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
