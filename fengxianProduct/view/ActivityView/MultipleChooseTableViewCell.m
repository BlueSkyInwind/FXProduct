//
//  MultipleChooseTableViewCell.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/7/1.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MultipleChooseTableViewCell.h"

@implementation MultipleChooseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setAnswerRowsModel:(AnswerRowsModel *)answerRowsModel{
    _answerRowsModel = answerRowsModel;
    contentheightArr = [NSMutableArray array];
    self.titleLabel.text = [NSString stringWithFormat:@"%ld、%@", (long)self.number,_answerRowsModel.Title];
    NSString * str = _answerRowsModel.Review;
    contentArr = [[str componentsSeparatedByString:@":"] mutableCopy];
    [self addChooseView];

}
-(void)addChooseView{
    
    for (int i = 0; i < contentArr.count; i ++ ) {
        NSString * str = contentArr[i];
        float height = [Tool heightForText:str width:_k_w - 50 font:14] + 5;
        ChooseView * chooseView = [[NSBundle mainBundle]loadNibNamed:@"ChooseView" owner:self options:nil].lastObject;
        chooseView.delegate = self;
        chooseView.selectedBtn.tag = 1000 + i;
        [chooseView.selectedBtn setImage:[UIImage imageNamed:@"answer_Multiple_unselected_Icon"] forState:UIControlStateNormal];
        chooseView.contentLabel.text =contentArr[i];
        chooseView.isSingle = NO;
        if (i == 0) {
            chooseView.frame = CGRectMake(0, 30, self.contentView.frame.size.width, height);
        }else{
            float originY = 26;
            for (NSNumber * height in contentheightArr) {
                originY += [height floatValue];
            }
            chooseView.frame = CGRectMake(0, originY + 5, self.contentView.frame.size.width, height);
        }
        [self.contentView addSubview:chooseView];
        [contentheightArr addObject:@(height)];

    }
}

-(void)chooseButtonClick:(UIButton *)button isSelected:(BOOL)isSelected{
    NSInteger num = button.tag - 1000;
    if (isSelected) {
        [button setImage:[UIImage imageNamed:@"answer_Multiple_selected_Icon"] forState:UIControlStateNormal];
    }else{
        [button setImage:[UIImage imageNamed:@"answer_Multiple_unselected_Icon"] forState:UIControlStateNormal];
    }
    if (self.multipleChoose) {
        self.multipleChoose([NSString stringWithFormat:@"%ld",(long)num], !isSelected,self.number);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
