//
//  ActivityBrokeViewTableViewCell.h
//  fengxianProduct
//
//  Created by admin on 2017/6/15.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WriteInfoView.h"

typedef void (^ActivityBrokeViewTableViewHeight)(NSInteger  height);

@interface ActivityBrokeViewTableViewCell : UITableViewCell{
    
    BOOL isBaoliao;
    BOOL isContribute;
    
}
@property (strong,nonatomic)WriteInfoView * writeInfoView;

@property (weak, nonatomic) IBOutlet UIButton *baoliaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *contributeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *updateList;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,strong)ColumnInfoModel * columnInfoM;

@property (nonatomic,strong)UIViewController * vc;
@property (nonatomic,copy)ActivityBrokeViewTableViewHeight activityBrokeViewTableViewHeight;


@end
