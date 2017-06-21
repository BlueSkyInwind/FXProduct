//
//  CommentModel.h
//  fengxianProduct
//
//  Created by admin on 2017/6/21.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol DetailCommentModel

@end

@interface DetailCommentModel : JSONModel

@property (nonatomic,strong)NSString<Optional> * Images;
@property (nonatomic,strong)NSString<Optional> * Image3;
@property (nonatomic,strong)NSString<Optional> * CommentNum;
@property (nonatomic,strong)NSString<Optional> * Time;
@property (nonatomic,strong)NSString<Optional> * Conten;
@property (nonatomic,strong)NSString<Optional> * Reply;
@property (nonatomic,strong)NSString<Optional> * ThumbNum;
@property (nonatomic,strong)NSDictionary<Optional> * lower;
@property (nonatomic,strong)NSString<Optional> * Name;
@property (nonatomic,strong)NSString<Optional> * ID;
@property (nonatomic,strong)NSString<Optional> * Star;
@property (nonatomic,strong)NSNumber<Optional> * success;

@end

@interface CommentModel : JSONModel

@property (nonatomic,strong)NSString<Optional> * total;
@property (nonatomic,strong)NSNumber<Optional> * Next;
@property (nonatomic,strong)NSString<Optional> * LastReplyTime;
@property (nonatomic,strong)NSArray<DetailCommentModel> * rows;


@end
