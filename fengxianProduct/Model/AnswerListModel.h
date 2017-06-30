//
//  AnswerListModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/29.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol AnswerListDetailModel <NSObject>



@end

@interface AnswerListDetailModel : JSONModel

@property (nonatomic,strong)NSString<Optional> * ID;
@property (nonatomic,strong)NSString<Optional> * Title;
@property (nonatomic,strong)NSString<Optional> * Num;
@property (nonatomic,strong)NSString<Optional> * Image1;
@property (nonatomic,strong)NSString<Optional> * Type;
@property (nonatomic,strong)NSString<Optional> * Introduce;


@end

@interface AnswerListModel : JSONModel
@property (nonatomic,strong)NSNumber * Next;
@property (nonatomic,strong)NSArray<AnswerListDetailModel> * rows;

@end
