//
//  ColumnModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/11.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ColumnInfoModel

@end

@interface ColumnInfoModel : JSONModel

@property (nonatomic,strong)NSNumber * ColumnID;
@property (nonatomic,strong)NSString * Img;
@property (nonatomic,strong)NSString * Title;
@property (nonatomic,strong)NSNumber * According;

@end


@interface ColumnModel : JSONModel

@property (nonatomic,strong)NSArray<ColumnInfoModel>* rows;

@end
