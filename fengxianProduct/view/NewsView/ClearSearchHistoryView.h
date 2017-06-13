//
//  ClearSearchHistoryView.h
//  fengxianProduct
//
//  Created by admin on 2017/6/13.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^DeleteSearchHistory)(UIButton * button);
@interface ClearSearchHistoryView : UIView
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong,nonatomic)DeleteSearchHistory deleteSearchHistory;


@end
