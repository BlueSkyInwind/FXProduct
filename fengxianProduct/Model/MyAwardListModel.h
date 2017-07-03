//
//  MyAwardListModel.h
//  fengxianProduct
//
//  Created by admin on 2017/7/3.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol MyAwardDetailListModel <NSObject>

@end

@interface MyAwardDetailListModel : JSONModel

@property (nonatomic,strong)NSString<Optional> * Integral;
@property (nonatomic,strong)NSString<Optional> * Title;
@property (nonatomic,strong)NSString<Optional> * Time;
@property (nonatomic,strong)NSString<Optional> * States;

@end


@interface MyAwardListModel : JSONModel

@property (nonatomic,strong)NSNumber * total;
@property (nonatomic,strong)NSNumber * Next;
@property (nonatomic,strong)NSArray<MyAwardDetailListModel> * rows;

@end
