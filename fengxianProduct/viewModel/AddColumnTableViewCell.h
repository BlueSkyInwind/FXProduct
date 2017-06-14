//
//  AddColumnTableViewCell.h
//  fengxianProduct
//
//  Created by admin on 2017/6/14.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddColumnTableViewCellDelegate <NSObject>

-(void)columnViewOneTap;
-(void)columnViewTwoTap;
-(void)columnViewThreeTap;
-(void)columnViewFourTap;

-(void)editBottonCilck;

@end


@interface AddColumnTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *columnViewOne;

@property (weak, nonatomic) IBOutlet UIView *columnViewTwo;

@property (weak, nonatomic) IBOutlet UIView *columnViewThree;

@property (weak, nonatomic) IBOutlet UIView *columnViewFour;

@property (weak, nonatomic) IBOutlet UIImageView *columnViewOneImage;

@property (weak, nonatomic) IBOutlet UIImageView *columnViewTwoImage;
@property (weak, nonatomic) IBOutlet UIImageView *columnViewThreeImage;
@property (weak, nonatomic) IBOutlet UIImageView *columnViewFourImage;
@property (weak, nonatomic) IBOutlet UILabel *columnViewOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *columnViewTwoLabel;

@property (weak, nonatomic) IBOutlet UILabel *columnViewThreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *columnViewFourLabel;

@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (assign, nonatomic)id<AddColumnTableViewCellDelegate>delegate;
@property (strong , nonatomic)NSMutableArray * dataArr;

@end
