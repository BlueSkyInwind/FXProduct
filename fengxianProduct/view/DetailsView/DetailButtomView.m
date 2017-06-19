//
//  DetailButtomView.m
//  fengxianProduct
//
//  Created by admin on 2017/6/19.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "DetailButtomView.h"
#import "CommentTableViewCell.h"

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
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
