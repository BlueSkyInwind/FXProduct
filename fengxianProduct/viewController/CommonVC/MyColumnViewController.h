//
//  MyColumnViewController.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/11.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^ColumnResult)(NSMutableArray * resultArr);
@interface MyColumnViewController : BaseViewController

@property (strong,nonatomic)NSMutableArray * dataArr;
@property (strong,nonatomic)NSString * columnType;

@property (copy,nonatomic)ColumnResult columnResult;

@end


