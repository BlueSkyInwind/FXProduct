//
//  NewsTableViewCell.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/11.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.atlasLabel.hidden = YES;
    self.vdieoBtn.hidden = YES;
}

-(void)configureViewTitleImage:(NSString *)imageName titleLabel:(NSString *)title titleLocation:(NSString *)Location titleType:(NSString *)type visitorNum:(NSString *)visitor commentNum:(NSString *)comment imageType:(NSInteger)imageType{
    
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"user_Icon" ]options:SDWebImageRefreshCached];
    self.titleLabel.text = title;
    self.titleLocation.text = Location;
    self.titleType.text = type;
    self.visitorNum.text = visitor;
    self.commentNum.text = comment;
    if (imageType == 2) {
        self.atlasLabel.hidden = NO;
    }else if (imageType == 3){
        self.vdieoBtn.hidden = NO;
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
