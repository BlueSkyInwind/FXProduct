//
//  ColumnViewModel.h
//  fengxianProduct
//
//  Created by admin on 2017/6/13.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ViewModelClass.h"

@interface ColumnViewModel : ViewModelClass

/**
 获取不同类型的栏目
 
 @param number 类型的id
 */
- (void)fatchColumnListType:(NSString *)number;

/**
 上传用户的栏目
 
 @param number 栏目的类型
 @param Column 栏目的内容
 */
- (void)uploadColumnListType:(NSString *)number Column:(NSString *)Column;

@end
