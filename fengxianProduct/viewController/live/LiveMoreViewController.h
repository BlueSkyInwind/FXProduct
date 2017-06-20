//
//  LiveMoreViewController.h
//  fengxianProduct
//
//  Created by admin on 2017/6/20.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColumnModel.h"

@interface LiveMoreViewController : BaseViewController

@property (nonatomic,strong)ColumnInfoModel *columnInfoModel;
@property (nonatomic,assign)NSInteger columnID;
@property (nonatomic,strong)NSString * titleName;

@end
