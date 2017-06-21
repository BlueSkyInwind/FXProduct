//
//  DetailButtomView.m
//  fengxianProduct
//
//  Created by admin on 2017/6/19.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "DetailButtomView.h"
#import "CommentTableViewCell.h"
#import "NewsViewModel.h"
#import "PopCommentInput.h"
@implementation DetailButtomView

-(void)awakeFromNib{
    [super awakeFromNib];
    [Tool setCorner:self.browseNumView borderColor:kUIColorFromRGB(0xe5e5e5) cornerRadius:1];
    [Tool setCorner:self.spotNumView borderColor:kUIColorFromRGB(0xe5e5e5) cornerRadius:1];

    UITapGestureRecognizer * spotTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(spotViewCilck)];
    [self.spotNumView addGestureRecognizer:spotTap];
    
    self.commentTableView.delegate =self;
    self.commentTableView.dataSource = self;
    self.commentTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.commentTableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommentTableViewCell"];
    
}
-(void)spotViewCilck{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(DetailSpotButtonClick)]) {
        [self.delegate DetailSpotButtonClick];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 90;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CommentTableViewCell"];
    }
    cell.detailCommentModel = self.detailCommentModel;
    cell.commentEventClick = ^(UITapGestureRecognizer *tap) {
        PopCommentInput * popComment = [PopCommentInput share];
        popComment.detailID = self.detailID;
        popComment.commentId = self.detailCommentModel.ID;
        [popComment showCommentView];
    };
    cell.spotEventClick = ^(UITapGestureRecognizer *tap) {
        [self requestSpot:self.detailCommentModel.ID];
    };

    return cell;
}
-(void)requestSpot:(NSString *)commentId{
    NewsViewModel * newViewM = [[NewsViewModel alloc]init];
    [newViewM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            NSString * number = (NSString *)returnMsg.msg;
            if ([number isEqualToString:@"1"]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self message:@"点赞成功"];
                
            }else if ([number isEqualToString:@"2"]){
                [[MBPAlertView sharedMBPTextView] showTextOnly:self message:@"取消点赞"];
            }
        }
    } WithFaileBlock:^{
        
    }];
    [newViewM fatchCommentSpotStatus:commentId];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
