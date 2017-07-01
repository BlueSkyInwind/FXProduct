//
//  GuideViewController.h
//  fengxianProduct
//
//  Created by admin on 2017/6/29.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideViewController : UIViewController
+ (instancetype)newGuideVCWithModels:(NSArray *)models enterBlock:(void(^)())enterBlock;

+(BOOL)canShowNewFeature;


@end
