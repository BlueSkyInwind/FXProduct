//
//  CommentMessageModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/26.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol CommentMessageDetailModel <NSObject>



@end

@interface CommentMessageDetailModel : JSONModel

@property (nonatomic,strong)NSString<Optional> * Name;
@property (nonatomic,strong)NSString<Optional> * Images;
@property (nonatomic,strong)NSString<Optional> * FConten;
@property (nonatomic,strong)NSString<Optional> * Conten;
@property (nonatomic,strong)NSString<Optional> * Time;
@property (nonatomic,strong)NSString<Optional> * Type;
@property (nonatomic,strong)NSString<Optional> * ID;
@property (nonatomic,strong)NSNumber<Optional> * ComID;


@end



@interface CommentMessageModel : JSONModel

@property (nonatomic,strong)NSNumber * total;
@property (nonatomic,strong)NSNumber * Next;
@property (nonatomic,strong)NSArray<CommentMessageDetailModel>  * rows;

@end
