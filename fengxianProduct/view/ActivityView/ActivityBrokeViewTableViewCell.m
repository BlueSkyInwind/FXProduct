//
//  ActivityBrokeViewTableViewCell.m
//  fengxianProduct
//
//  Created by admin on 2017/6/15.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ActivityBrokeViewTableViewCell.h"
#import "WriteInfoView.h"

@interface ActivityBrokeViewTableViewCell(){
    
    

}
@property (strong,nonatomic)WriteInfoView * writeInfoView;
@end

@implementation ActivityBrokeViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.baoliaoBtn.layer.cornerRadius = 3;
    self.baoliaoBtn.clipsToBounds = YES;
    self.contributeBtn.layer.cornerRadius = 3;
    self.contributeBtn.clipsToBounds = YES;
    
    isBaoliao = NO;
    isContribute = NO;
    
}

- (IBAction)baoliaoBtnClick:(id)sender {
    isBaoliao = !isBaoliao;
    if (isContribute) {
        isContribute = !isContribute;
        [self.contributeBtn setBackgroundColor:kUIColorFromRGB(0x5e5e5e)];
    }
    if (isBaoliao) {
        [self.baoliaoBtn setBackgroundColor:UI_MAIN_COLOR];
        [self loadWriteInfoView:1];
    }else{
        [self.baoliaoBtn setBackgroundColor:kUIColorFromRGB(0x5e5e5e)];
        [self removeWriteInfoView];
    }
    
}
- (IBAction)contributeBtnClick:(id)sender {
    
    isContribute = !isContribute;
    if (isBaoliao) {
        isBaoliao = !isBaoliao;
        [self.baoliaoBtn setBackgroundColor:kUIColorFromRGB(0x5e5e5e)];
    }
    if (isContribute) {
        [self.contributeBtn setBackgroundColor:UI_MAIN_COLOR];
        [self loadWriteInfoView:2];

    }else{
        [self.contributeBtn setBackgroundColor:kUIColorFromRGB(0x5e5e5e)];
        [self removeWriteInfoView];
    }
    
}
/**
 加载信息填写页面

 @param type 1，爆料  2，投稿
 */
-(void)loadWriteInfoView:(NSInteger)type{
    
    if (self.writeInfoView) {
        if (type == 1) {
            self.writeInfoView.contributeView.hidden= YES;
        }else{
            self.writeInfoView.contributeView.hidden= NO;
        }
        return;
    }
    self.writeInfoView = [[NSBundle mainBundle]loadNibNamed:@"WriteInfoView" owner:self options:nil].lastObject;
    self.writeInfoView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.writeInfoView];
    [self.writeInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    if (type == 1) {
        self.writeInfoView.contributeView.hidden= YES;
    }else{
        self.writeInfoView.contributeView.hidden= NO;
    }
    if (self.activityBrokeViewTableViewHeight) {
        self.activityBrokeViewTableViewHeight(520);
    }

}
-(void)removeWriteInfoView{
    
    [self.writeInfoView removeFromSuperview];
    self.writeInfoView = nil;
    if (self.activityBrokeViewTableViewHeight) {
        self.activityBrokeViewTableViewHeight(220);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
