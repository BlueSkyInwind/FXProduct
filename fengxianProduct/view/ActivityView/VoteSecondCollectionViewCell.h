//
//  VoteSecondCollectionViewCell.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/28.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoteDetailModel.h"
typedef void (^VoteChoose)(BOOL isSelected);

@interface VoteSecondCollectionViewCell : UICollectionViewCell{
    BOOL isSelected;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *voteObjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *location;

@property (weak, nonatomic) IBOutlet UILabel *voteNum;

@property (weak, nonatomic) IBOutlet UIButton *seletedButton;

@property (assign,nonatomic)NSInteger number;
@property (assign,nonatomic)NSNumber * voteNumber;

@property (nonatomic,copy)VoteChoose votechoose;
@property (nonatomic,strong)VoteRowsModel * voteRowsM;


@end
