//
//  DateAndWeatherView.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/11.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "DateAndWeatherView.h"
#import "FXWebViewController.h"

@implementation DateAndWeatherView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self obtainTodayDate];
    [self loadWeatherView];
}
-(void)obtainTodayDate{
    
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] ;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger week = [comps weekday];
//    NSInteger year=[comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
        self.dateLabel.text = [NSString stringWithFormat:@"%ld月%ld日    %@",(long)month,(long)day,[arrWeek objectAtIndex:week - 1]];
}


-(void)loadWeatherView{
    //http://i.tianqi.com/index.php?c=code&id=52&icon=1&num=3&py=fengxian
    
    [self.weatherView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#e5e5e5'"];      self.weatherView.backgroundColor = [UIColor clearColor];
    [self.weatherView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://i.tianqi.com/index.php?c=code&id=52&icon=1&num=3&py=fengxian"]]];
    
}
- (IBAction)weatherBtnClick:(id)sender {
    
    FXWebViewController * fxWebVC = [[FXWebViewController alloc]init];
    fxWebVC.urlStr = @"http://wx.weather.com.cn/mweather/101021000.shtml";
    [self.vc.navigationController pushViewController:fxWebVC animated:YES];
    
}
// 允许多个手势并发
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
