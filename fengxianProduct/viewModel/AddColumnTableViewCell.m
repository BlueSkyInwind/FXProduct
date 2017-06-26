//
//  AddColumnTableViewCell.m
//  fengxianProduct
//
//  Created by admin on 2017/6/14.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "AddColumnTableViewCell.h"
#import "ColumnModel.h"
@implementation AddColumnTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [Tool setCornerWithoutRadius:self.backView borderColor:kUIColorFromRGB(0xc0c0c0)];

     UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(columnViewOneClick)];
    [self.columnViewOne addGestureRecognizer:tap1];
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(columnViewTwoClick)];
    [self.columnViewTwo addGestureRecognizer:tap2];
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(columnViewThreeClick)];
    [self.columnViewThree addGestureRecognizer:tap3];
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(columnViewFourClick)];
    [self.columnViewFour addGestureRecognizer:tap4];
    
    self.columnViewOne.hidden  = YES;
    self.columnViewTwo.hidden  = YES;
    self.columnViewThree.hidden  = YES;
    self.columnViewFour.hidden  = YES;
    
}
-(void)layoutSubviews{
    self.columnViewOne.hidden  = YES;
    self.columnViewTwo.hidden  = YES;
    self.columnViewThree.hidden  = YES;
    self.columnViewFour.hidden  = YES;
    for (int   i = 0; i < _dataArr.count; i ++) {
        ColumnInfoModel * columnM = _dataArr[i];
        switch (i) {
            case 0:{
                self.columnViewOne.hidden = NO;
                [self.columnViewOneImage sd_setImageWithURL:[NSURL URLWithString:columnM.Img] placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_1" ]options:SDWebImageRefreshCached];
                self.columnViewOneLabel.text = columnM.Title;
            }
                break;
            case 1:{
                self.columnViewTwo.hidden = NO;
                [self.columnViewTwoImage sd_setImageWithURL:[NSURL URLWithString:columnM.Img] placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_1" ]options:SDWebImageRefreshCached];
                self.columnViewTwoLabel.text = columnM.Title;
            }
                break;
            case 2:{
                self.columnViewThree.hidden = NO;
                [self.columnViewThreeImage sd_setImageWithURL:[NSURL URLWithString:columnM.Img] placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_1" ]options:SDWebImageRefreshCached];
                self.columnViewThreeLabel.text = columnM.Title;
            }
                break;
            case 3:{
                self.columnViewFour.hidden = NO;
                [self.columnViewFourImage sd_setImageWithURL:[NSURL URLWithString:columnM.Img] placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_1" ]options:SDWebImageRefreshCached];
                self.columnViewFourLabel.text = columnM.Title;
            }
                break;
            default:
                break;
        }
    }

}

-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    [self setNeedsLayout];

    }
- (IBAction)editBtnClick:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(editBottonCilck)]) {
        [self.delegate editBottonCilck];
    }

}
-(void)columnViewOneClick{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(columnViewOneTap)]) {
        [self.delegate columnViewOneTap];
        self.columnViewOneLabel.textColor = UI_MAIN_COLOR;
    }
}
-(void)columnViewTwoClick{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(columnViewTwoTap)]) {
        [self.delegate columnViewTwoTap];
        self.columnViewTwoLabel.textColor = UI_MAIN_COLOR;
    }
}

-(void)columnViewThreeClick{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(columnViewThreeTap)]) {
        [self.delegate columnViewThreeTap];
        self.columnViewThreeLabel.textColor = UI_MAIN_COLOR;
    }
}

-(void)columnViewFourClick{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(columnViewFourTap)]) {
        [self.delegate columnViewFourTap];
        self.columnViewFourLabel.textColor = UI_MAIN_COLOR;
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
