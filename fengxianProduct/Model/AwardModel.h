//
//  AwardModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/7/2.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>



@protocol AwardGoodsModel <NSObject>



@end

@interface AwardGoodsModel : JSONModel

@property (nonatomic,strong)NSString<Optional> * Image;
@property (nonatomic,strong)NSString<Optional> * ID;
@property (nonatomic,strong)NSString<Optional> * Title;

@end


@interface AwardModel : JSONModel

@property (nonatomic,strong)NSString<Optional> * UserIntegral;
@property (nonatomic,strong)NSString<Optional> * LuckyIntegral;
@property (nonatomic,strong)NSString<Optional> * Text;
@property (nonatomic,strong)NSString<Optional> * States;
@property (nonatomic,strong)NSString<Optional> * total;
@property (nonatomic,strong)NSArray<AwardGoodsModel> * rows;

@end








