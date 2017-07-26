//
//  NewsTableViewCell.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/11.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsListModel.h"
#import "FLAnimatedImageView.h"

@interface NewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet FLAnimatedImageView *titleImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleType;
@property (weak, nonatomic) IBOutlet UILabel *titleLocation;
@property (weak, nonatomic) IBOutlet UILabel *visitorNum;

@property (weak, nonatomic) IBOutlet UILabel *commentNum;

@property (weak, nonatomic) IBOutlet UILabel *atlasLabel;
@property (weak, nonatomic) IBOutlet UIButton *vdieoBtn;
@property (weak, nonatomic) IBOutlet UIImageView *commentImage;

@property (weak, nonatomic) IBOutlet UIImageView *visitorImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *visitorImageLeftCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLocationCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLocationBottom;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLocationHeight;

@property (strong ,nonatomic)NewsListInfo * newsList;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *visitorBackViewWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *visitorLabelWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pluLabelWidth;


/**
 cell数据

 @param imageName 图片URL
 @param title 标题
 @param Location 信息来源
 @param type 类型
 @param visitor 访问量
 @param comment 评论数量
 @param imageType cell类型  2，图集  3，视频  1，普通
 */
-(void)configureViewTitleImage:(NSString *)imageName titleLabel:(NSString *)title titleLocation:(NSString *)Location titleType:(NSString *)type visitorNum:(NSString *)visitor commentNum:(NSString *)comment imageType:(NSInteger)imageType;




@end
