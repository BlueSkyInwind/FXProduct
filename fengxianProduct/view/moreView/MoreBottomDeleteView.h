//
//  MoreBottomDeleteView.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/25.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BottomDeleteTap)(UITapGestureRecognizer *tap);

@interface MoreBottomDeleteView : UIView
@property (weak, nonatomic) IBOutlet UIView *tapDeleteView;

@property (copy,nonatomic)BottomDeleteTap bottomDeleteTap;
@end
