//
//  VoteSecondCollectionViewCell.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/28.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VoteSecondCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *voteObjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *location;

@property (weak, nonatomic) IBOutlet UILabel *voteNum;

@property (weak, nonatomic) IBOutlet UIButton *seletedButton;


@end
