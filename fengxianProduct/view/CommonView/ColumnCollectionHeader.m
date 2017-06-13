//
//  ColumnCollectionHeader.m
//  fengxianProduct
//
//  Created by admin on 2017/6/13.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ColumnCollectionHeader.h"

@implementation ColumnCollectionHeader

-(void)awakeFromNib{
    [super awakeFromNib];
    isEditing = NO;
    self.closeEditBtn.hidden = YES;
    self.statusBtnRightConstraint.constant = 10;
    self.statusBtn.layer.cornerRadius = 3;
    self.statusBtn.layer.masksToBounds = YES;

}
- (IBAction)statusBtnClick:(id)sender {
    if (isEditing) {
        //完成编辑
        [self.statusBtn setTitle:@"编辑" forState:UIControlStateNormal];
        self.statusBtnRightConstraint.constant = 10;
        if (self.delegate && [self.delegate respondsToSelector:@selector(saveEditStatus)]) {
            [self.delegate saveEditStatus];
        }
    }else{
        //开始编辑
        [self.statusBtn setTitle:@"完成" forState:UIControlStateNormal];
        self.statusBtnRightConstraint.constant = 36;
        self.closeEditBtn.hidden = NO;
        if (self.delegate && [self.delegate respondsToSelector:@selector(startEditStatus)]) {
            [self.delegate startEditStatus];
        }
    }
    isEditing = !isEditing;
}
- (IBAction)closeBtnClick:(id)sender {
    //关闭编辑
    isEditing = NO;
    [self.statusBtn setTitle:@"编辑" forState:UIControlStateNormal];
    self.statusBtnRightConstraint.constant = 10;
    self.closeEditBtn.hidden = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(startEditStatus)]) {
        [self.delegate startEditStatus];
    }
}

-(void)chanageEditStatusAnimaiton{
    if (isEditing) {
        [UIView animateWithDuration:1 animations:^{
            self.statusBtnRightConstraint.constant = 10;
            
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:1 animations:^{
            self.statusBtnRightConstraint.constant = 36;
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
