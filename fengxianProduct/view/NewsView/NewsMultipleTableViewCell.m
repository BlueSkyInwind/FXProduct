//
//  NewsMultipleTableViewCell.m
//  fengxianProduct
//
//  Created by admin on 2017/6/12.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "NewsMultipleTableViewCell.h"

@implementation NewsMultipleTableViewCell

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
    [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:self.newsList.Image2] placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_1" ]options:SDWebImageRefreshCached];
    [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:self.newsList.Image3] placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_1" ]options:SDWebImageRefreshCached];
    self.titleLabel.text = self.newsList.Title;
    self.locationLabel.text = self.newsList.Source;
    self.titleType.text = self.newsList.Column;
//    self.visitorNum.text = [NSString stringWithFormat:@"%@",self.newsList.Num];
//    //[Tool DealWithResult:self.newsList.Num]
//    self.commentNumLabel.text = [NSString stringWithFormat:@"%@",self.newsList.PLNum];
    self.visitorNum.text = [Tool DealWithResult:self.newsList.Num];
    self.commentNumLabel.text = [Tool DealWithResult:self.newsList.PLNum];
    self.visitorLabelWith.constant = [Tool widthForText:self.visitorNum.text font:10] + 5;
    self.commentLabelWidth.constant = [Tool widthForText:self.commentNumLabel.text font:10] + 5;
    self.visitorBackViewWidth.constant = 34 + self.self.commentLabelWidth.constant + self.visitorLabelWith.constant;

}


-(void)configureViewTitleImageOne:(NSString *)imageName1 ImageTwo:(NSString *)imageName2 ImageThree:(NSString *)imageName3 titleLabel:(NSString *)title titleLocation:(NSString *)Location titleType:(NSString *)type visitorNum:(NSString *)visitor commentNum:(NSString *)comment imageType:(NSInteger)imageType{
    
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:imageName1] placeholderImage:[UIImage imageNamed:@"user_Icon" ]options:SDWebImageRefreshCached];
    [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:imageName2] placeholderImage:[UIImage imageNamed:@"user_Icon" ]options:SDWebImageRefreshCached];
    [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:imageName3] placeholderImage:[UIImage imageNamed:@"user_Icon" ]options:SDWebImageRefreshCached];
    
    self.titleLabel.text = title;
    self.locationLabel.text = Location;
    self.titleType.text = type;
    self.visitorNum.text = visitor;
    self.commentNumLabel.text = comment;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
