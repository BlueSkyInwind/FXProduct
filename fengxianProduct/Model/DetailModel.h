//
//  DetailModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/18.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol DetailCommentModel

@end

@interface DetailCommentModel : JSONModel

@property (nonatomic,strong)NSString<Optional> * Images;
@property (nonatomic,strong)NSNumber<Optional> * CommentNum;
@property (nonatomic,strong)NSString<Optional> * Time;
@property (nonatomic,strong)NSString<Optional> * Conten;
@property (nonatomic,strong)NSString<Optional> * Reply;
@property (nonatomic,strong)NSNumber<Optional> * ThumbNum;
@property (nonatomic,strong)NSString<Optional> * lower;
@property (nonatomic,strong)NSString<Optional> * Name;
@property (nonatomic,strong)NSNumber<Optional> * ID;
@property (nonatomic,strong)NSString<Optional> * Star;

@end



@interface DetailModel : JSONModel

@property (nonatomic,strong)NSString * Images;
@property (nonatomic,strong)NSString * MP4;
@property (nonatomic,strong)NSString * Share;
@property (nonatomic,strong)NSNumber * HomeType;
@property (nonatomic,strong)NSString * Title;
@property (nonatomic,strong)NSString * Source;
@property (nonatomic,strong)NSString * Auther;
@property (nonatomic,strong)NSNumber * Num;
@property (nonatomic,strong)NSNumber * ThNum;   //点赞数
@property (nonatomic,strong)NSNumber * PLNum;
@property (nonatomic,strong)NSString * Information;
@property (nonatomic,strong)NSString * Time;
@property (nonatomic,strong)NSString * LastReplyTime;
@property (nonatomic,strong)NSArray * rows;
@property (nonatomic,strong)NSArray * rows2;



@end
