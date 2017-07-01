//
//  VoteProgressCollectionViewCell.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/7/1.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoteDetailModel.h"

@interface VoteProgressCollectionViewCell : UICollectionViewCell{
    
    NSMutableArray * contentArr;
    
    NSMutableArray * contentheightArr;
}




@property (nonatomic,strong)VoteDetailModel * voteDetailModel;

@end
