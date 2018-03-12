//
//  NewsMultipleTableViewCell.h
//  fengxianProduct
//
//  Created by admin on 2017/6/12.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsListModel.h"

@interface NewsMultipleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;


@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleType;

@property (weak, nonatomic) IBOutlet UILabel *visitorNum;

@property (weak, nonatomic) IBOutlet UILabel *commentNumLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *visitorBackViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *visitorLabelWith;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentLabelWidth;



@property (strong ,nonatomic)NewsListInfo * newsList;


-(void)configureViewTitleImageOne:(NSString *)imageName1 ImageTwo:(NSString *)imageName2 ImageThree:(NSString *)imageName3 titleLabel:(NSString *)title titleLocation:(NSString *)Location titleType:(NSString *)type visitorNum:(NSString *)visitor commentNum:(NSString *)comment imageType:(NSInteger)imageType;



@end
