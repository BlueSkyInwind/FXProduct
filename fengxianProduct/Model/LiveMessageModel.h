//
//  LiveMessageModel.h
//  fengxianProduct
//
//  Created by admin on 2017/6/28.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol LivebadgeModel <NSObject>



@end

@interface LivebadgeModel : JSONModel

@property (nonatomic,strong)NSNumber<Optional> * ColumnID;
@property (nonatomic,strong)NSString<Optional> * Name;
@property (nonatomic,strong)NSNumber <Optional>* Count;

@end

@interface LiveMessageModel : JSONModel

@property (nonatomic,strong)NSArray<LivebadgeModel> * news;
@property (nonatomic,strong)NSArray * rows;

@end
