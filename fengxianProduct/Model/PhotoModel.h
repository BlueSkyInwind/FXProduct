//
//  PhotoModel.h
//  fengxianProduct
//
//  Created by admin on 2017/6/19.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol PhotoDetailModel

@end
@interface PhotoDetailModel : JSONModel

@property (nonatomic,strong)NSString * Image;
@property (nonatomic,strong)NSString * Cont;

@end


@interface PhotoModel : JSONModel

@property (nonatomic,strong)NSNumber * total;
@property (nonatomic,strong)NSArray<PhotoDetailModel> * Images;
@property (nonatomic,strong)NSString * Title;
@property (nonatomic,strong)NSString * Num;
@property (nonatomic,strong)NSString * ThNum;
@property (nonatomic,strong)NSString * PLNum;
@property (nonatomic,strong)NSString * LastReplyTime;
@property (nonatomic,strong)NSString * Share;
@property (nonatomic,strong)NSString * Information;


@end
