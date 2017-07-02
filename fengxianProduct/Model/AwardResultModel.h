//
//  AwardResultModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/7/2.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AwardResultModel : JSONModel
@property (nonatomic,strong)NSString<Optional> * ID;
@property (nonatomic,strong)NSString<Optional> * Title;
@property (nonatomic,strong)NSString<Optional> * Address;

@end
