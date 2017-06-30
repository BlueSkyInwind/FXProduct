//
//  VoteDetailView.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/30.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoteDetailModel.h"

@interface VoteDetailView : UIView


@property (nonatomic,strong)NSString * voteID;
@property (nonatomic,strong)NSNumber * voteType;
@property(nonatomic,strong)VoteDetailModel * voteDetailModel;

@end