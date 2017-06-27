//
//  NoticeView.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/27.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarqueeLabel.h"


typedef void (^CloseNoticeView)(UIButton * button);
@interface NoticeView : UIView
@property (weak, nonatomic) IBOutlet MarqueeLabel *scrollLabel;

@property (copy,nonatomic)CloseNoticeView closeNoticeView;
@end
