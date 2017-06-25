//
//  BrokeModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/25.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol BrokeDetailModel <NSObject>



@end

@interface BrokeDetailModel : JSONModel

@property (nonatomic,strong)NSString<Optional> * Title;
@property (nonatomic,strong)NSString<Optional> * Image;
@property (nonatomic,strong)NSString<Optional> * Url;
@property (nonatomic,strong)NSString<Optional> * ID;
@property (nonatomic,strong)NSString<Optional> * States;
@property (nonatomic,strong)NSString<Optional> * Species;
@property (nonatomic,strong)NSString<Optional> * Time;


@end


@interface BrokeModel : JSONModel

@property (nonatomic,strong)NSNumber * Next;
@property (nonatomic,strong)NSArray<BrokeDetailModel>  * rows;

@end
