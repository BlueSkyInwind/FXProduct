//
//  CommonBottomView.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/20.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonBottomView : UIView

@property (weak, nonatomic) IBOutlet UITextField *commentTextField;

@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *spotBtn;

@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet UIView *CommentViewIcon;


@end
