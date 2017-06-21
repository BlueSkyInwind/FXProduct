//
//  CommentTableViewCell.h
//  fengxianProduct
//
//  Created by admin on 2017/6/19.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"


typedef void (^CommentEventClick)(UITapGestureRecognizer * tap);
typedef void (^SpotEventClick)(UITapGestureRecognizer * tap);

@interface CommentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *accoutImage;

@property (weak, nonatomic) IBOutlet UILabel *accountName;
@property (weak, nonatomic) IBOutlet UILabel *commentTime;
@property (weak, nonatomic) IBOutlet UIImageView *spotImageView;
@property (weak, nonatomic) IBOutlet UILabel *commentNum;
@property (weak, nonatomic) IBOutlet UILabel *spotNum;

@property (weak, nonatomic) IBOutlet UIImageView *commentImageView;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;

@property (weak, nonatomic) IBOutlet UIView *secondComentView;
@property (weak, nonatomic) IBOutlet UILabel *secondName;
@property (weak, nonatomic) IBOutlet UILabel *secondTime;
@property (weak, nonatomic) IBOutlet UILabel *secondContent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondComentViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *redactReply;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *accoutContentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redactReplyHeight;

@property (nonatomic, strong)DetailCommentModel * detailCommentModel;
@property (nonatomic, copy)CommentEventClick  commentEventClick;
@property (nonatomic, copy)SpotEventClick  spotEventClick;



@end
