//
//  DateAndWeatherView.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/11.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateAndWeatherView : UIView<UIGestureRecognizerDelegate>
@property (nonatomic,strong)UIViewController * vc;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIWebView *weatherView;


@end
