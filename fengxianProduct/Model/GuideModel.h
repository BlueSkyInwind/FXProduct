//
//  GuideModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/7/1.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol GuideImageModel <NSObject>



@end

@interface GuideImageModel : JSONModel

@property (nonatomic,strong)NSString<Optional> * Image;

@end


@interface GuideModel : JSONModel

@property (nonatomic,strong)NSArray<GuideImageModel> * rows;

@end
