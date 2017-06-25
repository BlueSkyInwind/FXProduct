//
//  MyBaoliaoTableViewCell.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/25.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MyBaoliaoTableViewCell.h"

@implementation MyBaoliaoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.SeletedDeleteBtn.hidden = YES;
    self.statusLabelLeftCons.constant = 5;
}
- (IBAction)seletedDeleteBtnClick:(id)sender {
    
    isCanDelete = !isCanDelete;
    if (isCanDelete) {
        [self.SeletedDeleteBtn setBackgroundImage:[UIImage imageNamed:@"collect_Seleted_Delete"] forState:UIControlStateNormal];
    }else{
        [self.SeletedDeleteBtn setBackgroundImage:[UIImage imageNamed:@"collect_unseleted_Delete"] forState:UIControlStateNormal];
    }
    UIButton * button = (UIButton *)sender;
    if (self.selectedBtn) {
        self.selectedBtn(button.tag,isCanDelete);
    }
    
}
-(void)setBrokeDetailModel:(BrokeDetailModel *)brokeDetailModel{
    _brokeDetailModel = brokeDetailModel;
    
    isCanDelete = NO;
    self.contentLabel.text = brokeDetailModel.Title;
    self.timeLabel.text = brokeDetailModel.Time;
    if ([brokeDetailModel.States integerValue] == 0) {
        self.statusLabel.text = @"待审核";
        self.contentLabel.textColor = kUIColorFromRGB(0x5e5e5e);
        self.timeLabel.textColor = kUIColorFromRGB(0x5e5e5e);
        self.statusLabel.textColor = kUIColorFromRGB(0x5e5e5e);

    }else{
        self.statusLabel.text = @"审核通过";
        self.contentLabel.textColor = [UIColor blackColor];
    }
    if (_isDelete) {
        self.SeletedDeleteBtn.hidden = NO;
        self.statusLabelLeftCons.constant = 30;
    }else{
        self.SeletedDeleteBtn.hidden = YES;
        self.statusLabelLeftCons.constant = 10;
    }
    if (isCanDelete) {
        [self.SeletedDeleteBtn setBackgroundImage:[UIImage imageNamed:@"collect_Seleted_Delete"] forState:UIControlStateNormal];
    }else{
        [self.SeletedDeleteBtn setBackgroundImage:[UIImage imageNamed:@"collect_unseleted_Delete"] forState:UIControlStateNormal];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
    
    
}

@end
