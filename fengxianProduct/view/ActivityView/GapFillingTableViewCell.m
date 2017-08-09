//
//  GapFillingTableViewCell.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/7/1.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "GapFillingTableViewCell.h"

@implementation GapFillingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
    self.contenttextView.layer.borderColor = kUIColorFromRGB(0xe5e5e5).CGColor;
    self.contenttextView.layer.borderWidth = 1;
    
}
-(void)setAnswerRowsModel:(AnswerRowsModel *)answerRowsModel{
    _answerRowsModel = answerRowsModel;
    self.titleLabel.text = [NSString stringWithFormat:@"%ld、%@", (long)self.number,_answerRowsModel.Title];
    self.contenttextView.delegate = self;
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (self.contentResultStr) {
        self.contentResultStr(textView.text, self.number);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
