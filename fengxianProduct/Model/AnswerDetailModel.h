//
//  AnswerDetailModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/7/1.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>



@protocol AnswerRowsModel <NSObject>



@end

@interface AnswerRowsModel : JSONModel

@property (nonatomic,strong)NSString<Optional> * States;
@property (nonatomic,strong)NSString<Optional> * Title;
@property (nonatomic,strong)NSString<Optional> * Review;

@end


@interface AnswerDetailModel : JSONModel

@property (nonatomic,strong)NSNumber<Optional> * total;
@property (nonatomic,strong)NSString<Optional> * Title;
@property (nonatomic,strong)NSString<Optional> * ImageURL;
@property (nonatomic,strong)NSArray<AnswerRowsModel> * rows;

@end
