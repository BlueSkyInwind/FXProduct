//
//  SystemMessageModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/26.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>




@protocol SystemMessageDetailModel <NSObject>



@end

@interface SystemMessageDetailModel : JSONModel

@property (nonatomic,strong)NSString<Optional> * Time;
@property (nonatomic,strong)NSString<Optional> * Title;
@property (nonatomic,strong)NSString<Optional> * ID;
@property (nonatomic,strong)NSString<Optional> * Conten;
@property (nonatomic,strong)NSString<Optional> * Reading;

@end


@interface SystemMessageModel : JSONModel

@property (nonatomic,strong)NSNumber * total;
@property (nonatomic,strong)NSNumber * Next;
@property (nonatomic,strong)NSArray<SystemMessageDetailModel>  * rows;


@end
