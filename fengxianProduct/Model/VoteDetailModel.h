//
//  VoteDetailModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/30.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol VoteRowsModel <NSObject>



@end

@interface VoteRowsModel : JSONModel

@property (nonatomic,strong)NSString<Optional> * ID;
@property (nonatomic,strong)NSString<Optional> * Title;
@property (nonatomic,strong)NSString<Optional> * Num; 
@property (nonatomic,strong)NSString<Optional> * Image;
@property (nonatomic,strong)NSString<Optional> * Introduce;


@end

@interface VoteDetailModel : JSONModel

@property (nonatomic,strong)NSNumber<Optional> * success;
@property (nonatomic,strong)NSNumber<Optional> * total;
@property (nonatomic,strong)NSString<Optional> * Name;
@property (nonatomic,strong)NSString<Optional> * Image;
@property (nonatomic,strong)NSNumber<Optional> * Type;
@property (nonatomic,strong)NSNumber<Optional> * VoteNum;
@property (nonatomic,strong)NSString<Optional> * Introduction;
@property (nonatomic,strong)NSArray<VoteRowsModel> * rows;

@end
