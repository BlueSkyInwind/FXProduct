//
//  VoteListModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/29.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol VoteListDetailModel <NSObject>



@end

@interface VoteListDetailModel : JSONModel

@property (nonatomic,strong)NSString<Optional> * ID;
@property (nonatomic,strong)NSString<Optional> * Title;
@property (nonatomic,strong)NSString<Optional> * Num;
@property (nonatomic,strong)NSString<Optional> * Image;
@property (nonatomic,strong)NSString<Optional> * Type;
@property (nonatomic,strong)NSString<Optional> * Introduce;


@end

@interface VoteListModel : JSONModel

@property (nonatomic,strong)NSNumber * Next;
@property (nonatomic,strong)NSArray<VoteListDetailModel> * rows;

@end
