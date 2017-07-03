//
//  VoteThirdTableViewCell.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/28.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoteDetailModel.h"
typedef void (^VoteChoose)(BOOL isSelected);

@interface VoteThirdTableViewCell : UITableViewCell{
    BOOL isSelected;

}
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UIButton *seletButton;

@property (weak, nonatomic) IBOutlet UILabel *voteNum;

@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *voteProgressiew;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *voteProgressWidth;

@property (assign,nonatomic)NSInteger number;
@property (assign,nonatomic)NSNumber * voteNumber;

@property (nonatomic,strong)VoteRowsModel * voteRowsM;
@property (nonatomic,copy)VoteChoose votechoose;

@end
