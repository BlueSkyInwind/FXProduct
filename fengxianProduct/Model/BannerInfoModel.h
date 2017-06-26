//
//  BannerInfoModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/11.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol BannerInfoModel



@end
@interface BannerInfoModel : JSONModel

@property (nonatomic,strong)NSNumber * NewID;
@property(nonatomic,strong)NSString * Title;
@property(nonatomic,strong)NSNumber * Type;
@property(nonatomic,strong)NSString * Image;
@end

@interface BannerListModel : JSONModel

@property (nonatomic,strong)NSArray<BannerInfoModel> * rows;

@end


