//
//  PopCommentInput.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/21.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopCommentInput : NSObject

@property (nonatomic,strong)NSNumber * detailID;

@property (nonatomic,strong)NSString * commentId;

+(PopCommentInput *)share;
-(void)showCommentView;


@end
