//
//  ExplainView.h
//  fengxianProduct
//
//  Created by admin on 2017/6/19.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoModel.h"

@interface ExplainView : UIView
@property (weak, nonatomic) IBOutlet UILabel *imageNum;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic,strong)PhotoDetailModel * photoDetailModel;
@end
