//
//  CommentMessageTableViewCell.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/25.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentMessageModel.h"
typedef void (^SelectedBtn)(NSInteger num ,BOOL isCan);

@interface CommentMessageTableViewCell : UITableViewCell{
    BOOL isCanDelete;
    
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *replayContentLabel;

@property (weak, nonatomic) IBOutlet UIButton *seletedDeleteBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeLabelLeftCons;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *myCommentView;

@property (weak, nonatomic) IBOutlet UILabel *myCommentLabel;


@property (nonatomic,strong)CommentMessageDetailModel * commentMessageDetailModel;

@property (assign,nonatomic)BOOL isDelete;

@property (copy,nonatomic)SelectedBtn selectedBtn;


@end
