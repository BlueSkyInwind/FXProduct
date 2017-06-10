//
//  MySettingTableViewCell.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/10.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MySettingTableViewCell.h"

@implementation MySettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.wifiSwitch.hidden = YES;
    self.wifiSwitch.on = NO;
}
- (IBAction)wifiSwitchClick:(id)sender {
    UISwitch * wifi = (UISwitch *)sender;
    [Utility sharedUtility].isLoadImage = wifi.on;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
