//
//  VoteProgressCollectionViewCell.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/7/1.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "VoteProgressCollectionViewCell.h"
#import "VoteProgressView.h"
@implementation VoteProgressCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setVoteDetailModel:(VoteDetailModel *)voteDetailModel{
    _voteDetailModel = voteDetailModel;
    contentArr = [_voteDetailModel.rows mutableCopy];
    contentheightArr = [NSMutableArray array];
    [self addChooseView];
}

-(void)addChooseView{
    
    for (int i = 0; i < contentArr.count; i ++ ) {
        float height = 35;
        VoteProgressView * voteProgressView = [[NSBundle mainBundle]loadNibNamed:@"VoteProgressView" owner:self options:nil].lastObject;
        
        VoteRowsModel * voteRowM = contentArr[i];
        NSString * title = [NSString stringWithFormat:@"%d、%@", i+1,voteRowM.Title];
        float width = [Tool widthForText:title font:15];
        voteProgressView.titleLabel.text = title;
        voteProgressView.titleWidth.constant = width;
        voteProgressView.progressView.progress = [voteRowM.Num floatValue] / [_voteDetailModel.VoteNum floatValue];
        voteProgressView.percentLabel.text = [NSString stringWithFormat:@"%0.1f%%(%@)",[voteRowM.Num floatValue] / [_voteDetailModel.VoteNum floatValue] * 100,voteRowM.Num];
        
        if (i == 0) {
            voteProgressView.frame = CGRectMake(0, 5, self.contentView.frame.size.width, height);
        }else{
            float originY = 5;
            for (NSNumber * height in contentheightArr) {
                originY += [height floatValue];
            }
            voteProgressView.frame = CGRectMake(0, originY + 5, self.contentView.frame.size.width, height);
        }
        [self addSubview:voteProgressView];
        [contentheightArr addObject:@(height)];
    }
}


@end
