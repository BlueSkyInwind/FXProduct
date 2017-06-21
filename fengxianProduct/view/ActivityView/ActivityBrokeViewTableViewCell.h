//
//  ActivityBrokeViewTableViewCell.h
//  fengxianProduct
//
//  Created by admin on 2017/6/15.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ActivityBrokeViewTableViewHeight)(NSInteger  height);

@interface ActivityBrokeViewTableViewCell : UITableViewCell{
    
    BOOL isBaoliao;
    BOOL isContribute;
    
}

@property (weak, nonatomic) IBOutlet UIButton *baoliaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *contributeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (nonatomic,copy)ActivityBrokeViewTableViewHeight activityBrokeViewTableViewHeight;


@end
