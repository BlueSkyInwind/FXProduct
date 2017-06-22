//
//  CollectModel.h
//  fengxianProduct
//
//  Created by admin on 2017/6/22.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol CollectDetailModel <NSObject>



@end

@interface CollectDetailModel : JSONModel

@property (nonatomic,strong)NSString<Optional> * CommType;
@property (nonatomic,strong)NSNumber<Optional> * ID;
@property (nonatomic,strong)NSString<Optional> * Time;
@property (nonatomic,strong)NSString<Optional> * Title;
@property (nonatomic,strong)NSString<Optional> * Column;
@property (nonatomic,strong)NSNumber<Optional> * PLNum;
@property (nonatomic,strong)NSNumber<Optional> * Num;
@property (nonatomic,strong)NSNumber<Optional> * Seat;
@property (nonatomic,strong)NSString<Optional> * Source;
@property (nonatomic,strong)NSString<Optional> * Auther;
@property (nonatomic,strong)NSString<Optional> * Introduce;
@property (nonatomic,strong)NSNumber<Optional> * Species;
@property (nonatomic,strong)NSString<Optional> * Image1;
@property (nonatomic,strong)NSString<Optional> * Image2;
@property (nonatomic,strong)NSString<Optional> * Image3;
@property (nonatomic,strong)NSNumber<Optional> * Type;

@end


@interface CollectModel : JSONModel


@property (nonatomic,strong)NSNumber * total;
@property (nonatomic,strong)NSNumber * Next;
@property (nonatomic,strong)NSArray<NewsListInfo>  * rows;


@end
