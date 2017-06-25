//
//  UserCommentModel.h
//  fengxianProduct
//
//  Created by admin on 2017/6/15.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol UserCommentModel

@end
@interface UserCommentModel : JSONModel

@property (nonatomic,strong)NSString * Time;
@property (nonatomic,strong)NSString * Text;
@property (nonatomic,strong)NSString * Images;
@property (nonatomic,strong)NSNumber * ID;
@property (nonatomic,strong)NSNumber * States;

@end


@interface UserCommentListModel : JSONModel

@property (nonatomic,strong)NSNumber * total;
@property (nonatomic,strong)NSNumber * Next;
@property (nonatomic,strong)NSArray<UserCommentModel> * rows;
//@property (nonatomic,strong)NSArray * rows;


@end
