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

@property (nonatomic,strong)NSNumber<Optional> * NewID;
@property(nonatomic,strong)NSString<Optional> * Title;
@property(nonatomic,strong)NSNumber<Optional> * Type;
@property(nonatomic,strong)NSString<Optional> * Image;
@property(nonatomic,strong)NSString<Optional> * HasVideo;

@end

@interface BannerListModel : JSONModel

@property (nonatomic,strong)NSArray<BannerInfoModel> * rows;

@end


