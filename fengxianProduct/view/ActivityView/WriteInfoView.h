//
//  WriteInfoView.h
//  fengxianProduct
//
//  Created by admin on 2017/6/15.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXTextView.h"
@interface WriteInfoView : UIView

@property (weak, nonatomic) IBOutlet UIView *contributeView;

@property (weak, nonatomic) IBOutlet UIView *seletTypeView;

@property (weak, nonatomic) IBOutlet UILabel *typeTitleLabel;


@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@property (weak, nonatomic) IBOutlet XXTextView *contentTextView;

@property (weak, nonatomic) IBOutlet UIView *imageDispalyView;

@property (weak, nonatomic) IBOutlet UIButton *vedioClickBtn;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;



@end
