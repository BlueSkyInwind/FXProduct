//
//  VoteFirstTableViewCell.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/28.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoteDetailModel.h"

typedef void (^VoteChoose)(BOOL isSelected);
@interface VoteFirstTableViewCell : UITableViewCell{
    BOOL isSelected;
    
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *seletedButton;

@property (weak, nonatomic) IBOutlet UILabel *voteNumLabel;

@property (weak, nonatomic) IBOutlet UIProgressView *voteProgressView;

@property (assign,nonatomic)NSInteger number;
@property (assign,nonatomic)NSNumber * voteNum;

@property (nonatomic,strong)VoteRowsModel * voteRowsM;

@property (nonatomic,copy)VoteChoose votechoose;
@end
