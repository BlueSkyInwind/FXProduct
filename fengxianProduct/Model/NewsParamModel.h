//
//  NewsParamModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/25.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface NewsParamModel : JSONModel

@property (nonatomic,strong)NSString * AccountId;
@property (nonatomic,strong)NSString * Title;
@property (nonatomic,strong)NSString * Cont;
@property (nonatomic,strong)NSString * Species;
@property (nonatomic,strong)NSString * Images;
@property (nonatomic,strong)NSString * Mp4;


@end
