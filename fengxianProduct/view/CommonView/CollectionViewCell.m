//
//  CollectionViewCell.m
//  fengxianProduct
//
//  Created by admin on 2017/6/13.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.deleteImage.hidden = YES;
    self.titleLabel.layer.cornerRadius = 3;
    self.titleLabel.layer.masksToBounds = YES;
}



@end
