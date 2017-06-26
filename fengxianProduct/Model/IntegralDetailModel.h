//
//  IntegralDetailModel.h
//  fengxianProduct
//
//  Created by admin on 2017/6/26.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol IntegralDetailListModel <NSObject>


@end

@interface IntegralDetailListModel : JSONModel

@property (nonatomic,strong)NSString<Optional> * Integral;
@property (nonatomic,strong)NSString<Optional> * Title;
@property (nonatomic,strong)NSString<Optional> * Time;
@end



@interface IntegralDetailModel : JSONModel

@property (nonatomic,strong)NSNumber * total;
@property (nonatomic,strong)NSNumber * Next;
@property (nonatomic,strong)NSArray<IntegralDetailListModel>  * rows;

@end
