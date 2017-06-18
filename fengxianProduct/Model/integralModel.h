//
//  integralModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/18.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol integralGoodsModel

@end


@interface integralGoodsModel : JSONModel


@property (nonatomic,strong)NSNumber * ID;
@property (nonatomic,strong)NSString * Title;
@property (nonatomic,strong)NSString * Image;
@property (nonatomic,strong)NSNumber * Integral;
@property (nonatomic,strong)NSNumber * Num;

@end



@interface integralModel : JSONModel


@property (nonatomic,strong)NSNumber * total;
@property (nonatomic,strong)NSNumber * Integral;
@property (nonatomic,strong)NSArray<integralGoodsModel> * rows;
@end
