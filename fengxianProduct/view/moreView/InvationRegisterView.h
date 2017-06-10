//
//  InvationRegisterView.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/10.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserQrcodeShareView.h"
@interface InvationRegisterView : UIView<UserQrcodeShareViewDelegate>


+(void)showInvationView:(UIViewController *)viewController;


@end
