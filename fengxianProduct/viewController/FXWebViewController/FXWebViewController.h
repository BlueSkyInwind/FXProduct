//
//  FXWebViewController.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/7.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXWebViewController : BaseViewController

@property (nonatomic, copy)NSString *urlStr;
@property (nonatomic, copy)NSString *Content;
@property (nonatomic, copy)NSString *title;

@property (nonatomic, assign)BOOL isBlowUp;


@end
