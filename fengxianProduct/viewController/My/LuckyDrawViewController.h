//
//  LuckyDrawViewController.h
//  fengxianProduct
//
//  Created by admin on 2017/6/29.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "BaseViewController.h"

@interface LuckyDrawViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *awardBackView;

@property (weak, nonatomic) IBOutlet UILabel *integralNum;

@property (weak, nonatomic) IBOutlet UIView *beginAwardView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *awardBackViewTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *intgeralRuleHeight;

@property (weak, nonatomic) IBOutlet UILabel *intgeralRuleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *intgeralRuleViewBottom;

@end
