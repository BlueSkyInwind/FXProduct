//
//  SystemMessageTableViewCell.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/25.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "SystemMessageTableViewCell.h"

@implementation SystemMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)seletedDeleteBtnClick:(id)sender {
    
    isCanDelete = !isCanDelete;
    if (isCanDelete) {
        [self.seletedDeleteBtn setBackgroundImage:[UIImage imageNamed:@"collect_Seleted_Delete"] forState:UIControlStateNormal];
    }else{
        [self.seletedDeleteBtn setBackgroundImage:[UIImage imageNamed:@"collect_unseleted_Delete"] forState:UIControlStateNormal];
    }
    UIButton * button = (UIButton *)sender;
    if (self.selectedBtn) {
        self.selectedBtn(button.tag,isCanDelete);
    }
    
}

-(void)setSystemMessageDetailModel:(SystemMessageDetailModel *)systemMessageDetailModel{
    
    _systemMessageDetailModel = systemMessageDetailModel;
    isCanDelete = NO;
    self.contentLabel.text = systemMessageDetailModel.Conten;
    self.timeLabel.text = systemMessageDetailModel.Time;
        
    if (_isDelete) {
        self.seletedDeleteBtn.hidden = NO;
        self.contentLabelLeftCons.constant = 25;
    }else{
        self.seletedDeleteBtn.hidden = YES;
        self.contentLabelLeftCons.constant = 8;
    }
    if (isCanDelete) {
        [self.seletedDeleteBtn setBackgroundImage:[UIImage imageNamed:@"collect_Seleted_Delete"] forState:UIControlStateNormal];
    }else{
        [self.seletedDeleteBtn setBackgroundImage:[UIImage imageNamed:@"collect_unseleted_Delete"] forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
