//
//  GoodsDetailModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/27.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol GoodsTypeModel <NSObject>



@end

@interface GoodsTypeModel : JSONModel

@property (nonatomic,strong)NSString<Optional> * ID;
@property (nonatomic,strong)NSString<Optional> * Title;
@property (nonatomic,strong)NSString<Optional> * Num;


@end


@interface GoodsDetailModel : JSONModel

@property (nonatomic,strong)NSArray<Optional> * Images;
@property (nonatomic,strong)NSString<Optional> * Title;
@property (nonatomic,strong)NSString<Optional> * Integral;
@property (nonatomic,strong)NSString<Optional> * Information;
@property (nonatomic,strong)NSString<Optional> * Num;
@property (nonatomic,strong)NSString<Optional> * total;
@property (nonatomic,strong)NSArray<GoodsTypeModel> * rows;

@end
