//
//  VoteDetailSecondView.h
//  fengxianProduct
//
//  Created by admin on 2017/6/30.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoteDetailModel.h"

typedef void(^RequestVoteStatus)(BOOL isSuccess);
@interface VoteDetailSecondView : UIView
@property (nonatomic,strong)NSString * voteID;
@property (nonatomic,strong)NSNumber * voteType;
@property(nonatomic,strong)VoteDetailModel * voteDetailModel;
@property (nonatomic,copy)RequestVoteStatus requestVoteStatus;

@end
