//
//  NewsTwoTableViewCell.m
//  fengxianProduct
//
//  Created by admin on 2017/6/12.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "NewsTwoTableViewCell.h"

@implementation NewsTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setNewsList:(NewsListInfo *)newsList{
    _newsList = newsList;
    [self setNeedsLayout];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:self.newsList.Image1] placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_1" ]options:SDWebImageRefreshCached];
    [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:self.newsList.Image2] placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_2" ]options:SDWebImageRefreshCached];

    self.titleLabel.text = self.newsList.Title;
    self.titleLocation.text = self.newsList.Source;
    self.titleType.text = self.newsList.Column;
    self.visitorNum.text = [NSString stringWithFormat:@"%@",self.newsList.Num];
    self.commentNum.text = [NSString stringWithFormat:@"%@",self.newsList.PLNum];
}

-(void)configureViewTitleImageOne:(NSString *)imageName1  ImageTwo:(NSString *)imageName2 titleLabel:(NSString *)title titleLocation:(NSString *)Location titleType:(NSString *)type visitorNum:(NSString *)visitor commentNum:(NSString *)comment imageType:(NSInteger)imageType{
    
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:imageName1] placeholderImage:[UIImage imageNamed:@"user_Icon" ]options:SDWebImageRefreshCached];
    [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:imageName2] placeholderImage:[UIImage imageNamed:@"user_Icon" ]options:SDWebImageRefreshCached];
    self.titleLabel.text = title;
    self.titleLocation.text = Location;
    self.titleType.text = type;
    self.visitorNum.text = visitor;
    self.commentNum.text = comment;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
