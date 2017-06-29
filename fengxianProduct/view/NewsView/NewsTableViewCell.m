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
-(void)setNewsList:(NewsListInfo *)newsList{
    _newsList = newsList;
    [self setNeedsLayout];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.atlasLabel.hidden = YES;
    self.vdieoBtn.hidden = YES;

    if ([self.newsList.Image1 hasSuffix:@".gif"]) {
        self.titleImage.image = [UIImage imageNamed:@"news_placeholder_Icon_1" ];
        [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:self.newsList.Image1]  options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            self.titleImage.image = nil;
            self.titleImage.animatedImage  = [FLAnimatedImage animatedImageWithGIFData:data];
        }];
    }else{
        [self.titleImage sd_setImageWithURL:[NSURL URLWithString:self.newsList.Image1] placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_1" ]options:SDWebImageRefreshCached];
    }
    
    self.titleLabel.text = self.newsList.Title;
    if ([self.newsList.Source isEqualToString:@"原创"]) {
        self.titleLocation.textColor = [UIColor redColor];
    }
    self.titleLocation.text = self.newsList.Source;
    self.titleType.text = self.newsList.Column;
    self.visitorNum.text = [NSString stringWithFormat:@"%@",self.newsList.Num];
    self.commentNum.text = [NSString stringWithFormat:@"%@",self.newsList.PLNum];
    if ([self.newsList.Species integerValue] == 2) {
        self.atlasLabel.hidden = NO;
    }else if ([self.newsList.Species integerValue] == 3){
        self.vdieoBtn.hidden = NO;
    }
}

-(void)configureViewTitleImage:(NSString *)imageName titleLabel:(NSString *)title titleLocation:(NSString *)Location titleType:(NSString *)type visitorNum:(NSString *)visitor commentNum:(NSString *)comment imageType:(NSInteger)imageType{
    
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_1" ]options:SDWebImageRefreshCached];
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
