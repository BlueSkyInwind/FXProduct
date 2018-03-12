//
//  LivesContentTableViewCell.m
//  fengxianProduct
//
//  Created by admin on 2017/6/14.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ActivityContentTableViewCell.h"
#import "NewsTwoTableViewCell.h"
#import "NewsMultipleTableViewCell.h"
#import "NewsTableViewCell.h"
#import "NewsViewModel.h"
#import "ActivityBrokeViewTableViewCell.h"
#import "PhotoViewController.h"
#import "DetailViewController.h"
#import "VoteDetailFirstViewController.h"
#import "AnswerDetailViewController.h"
@implementation ActivityContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [Tool setCornerWithoutRadius:self.backView borderColor:[UIColor grayColor]];
    self.updateListNumLabel.layer.cornerRadius = self.updateListNumLabel.frame.size.width;
    self.updateListNumLabel.clipsToBounds = YES;
    self.updateListNumLabel.hidden = YES;
    [self.moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.leftIcon.hidden = NO;
    self.moreBtn.hidden= NO;
    baoliaoHeight = 220;
    
    [self configureView];

}

-(void)configureView{
    
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    self.contentTableView.backgroundColor = [UIColor whiteColor];
    self.contentTableView.scrollEnabled = NO;
    self.contentTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    
    [self.contentTableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTableViewCell"];
    [self.contentTableView registerNib:[UINib nibWithNibName:@"NewsTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTwoTableViewCell"];
    [self.contentTableView registerNib:[UINib nibWithNibName:@"NewsMultipleTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsMultipleTableViewCell"];
    
}

- (IBAction)moreBtnClick:(id)sender {
    
    if (self.moreButtonCilck) {
        self.moreButtonCilck(sender);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (!self.dataArr || self.dataArr.count == 0) {
        return 40;
    }
    NewsListInfo * newsList = self.dataArr[indexPath.row];
    if ([newsList.Seat intValue] == 1) {
        return 140;
    }else if ([newsList.Seat intValue] == 4){
        return 140;
    }
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArr.count == 0) {
        return 0;
    }
        return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    NewsListInfo * newsList = self.dataArr[indexPath.row];
    if ([newsList.Seat intValue] == 1) {
        NewsMultipleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsMultipleTableViewCell" forIndexPath:indexPath];
        cell.newsList = newsList;
        return cell;
    }else if ([newsList.Seat intValue] == 4){
        
        NewsTwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsTwoTableViewCell" forIndexPath:indexPath];
        cell.newsList = newsList;
        return cell;
    }
    NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"NewsTableViewCell"];
    }
    cell.newsList = newsList;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_columnInfoM.ColumnID intValue] == 11) {
        NewsListInfo * newsList = self.dataArr[indexPath.row];
        if ([newsList.Species integerValue] == 2) {
            PhotoViewController *photoVC = [[PhotoViewController alloc]init];
            photoVC.detailID = newsList.ID;
            photoVC.Species =  newsList.Species;
            [_currentVC.navigationController pushViewController:photoVC animated:YES];
        }else{
            DetailViewController *detailVC = [[DetailViewController alloc]init];
            detailVC.detailID = newsList.ID;
            detailVC.Species =  newsList.Species;
            [_currentVC.navigationController pushViewController:detailVC animated:YES];
        }
    }else if ([_columnInfoM.ColumnID intValue] == 9){
        if ([[ShareConfig share] isPresentLoginVC:_currentVC]) {
            NewsListInfo * newsList = self.dataArr[indexPath.row];
            VoteDetailFirstViewController * voteDetailVC  = [[VoteDetailFirstViewController alloc]init];
            voteDetailVC.voteID = [NSString stringWithFormat:@"%@",newsList.ID];
            voteDetailVC.voteTitle = newsList.Title;
            [_currentVC.navigationController pushViewController:voteDetailVC animated:YES];
        }
    }else if ([_columnInfoM.ColumnID intValue] == 10){
        if ([[ShareConfig share] isPresentLoginVC:_currentVC]) {
            NewsListInfo * newsList = self.dataArr[indexPath.row];
            AnswerDetailViewController * answerDetailVC  = [[AnswerDetailViewController alloc]init];
            answerDetailVC.answerID = [NSString stringWithFormat:@"%@",newsList.ID];
            answerDetailVC.answerTitle = newsList.Title;
            [_currentVC.navigationController pushViewController:answerDetailVC animated:YES];
        }
    }
}

-(void)setColumnInfoM:(ColumnInfoModel *)columnInfoM{
    _columnInfoM= nil;
    _columnInfoM = columnInfoM;
    [self layoutIfNeeded];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.text = _columnInfoM.Title;
    
    if (self.dataArr) {
        [self.contentTableView reloadData];
        return;
    }
    //缓存数据
    if([_columnInfoM.ColumnID intValue] == 9){
        self.dataArr =  [[Utility sharedUtility].voteListModel.rows mutableCopy];
    }else if([_columnInfoM.ColumnID intValue] == 10){
        self.dataArr =  [[Utility sharedUtility].answerListModel.rows mutableCopy];
    }else if([_columnInfoM.ColumnID intValue] ==11){
        self.dataArr =  [[Utility sharedUtility].welfareListModel.rows mutableCopy];
    }
    [self.contentTableView reloadData];
}

#pragma mrak - 数据请求
-(void)requestNewsListInfo:(NSNumber *)Id{
    if (self.dataArr) {
        [self.contentTableView reloadData];
        [self obtainCellHeight:self.dataArr ColmunId:Id];
        return;
    }
    NewsViewModel * newsVM = [[NewsViewModel alloc]init];
    [newsVM setBlockWithReturnBlock:^(id returnValue) {
        
        //缓存数据
        NewsListModel * newsListModel = returnValue;
        if([_columnInfoM.ColumnID intValue] == 9){
            [Utility sharedUtility].voteListModel = newsListModel;
        }else if([_columnInfoM.ColumnID intValue] == 10){
            [Utility sharedUtility].answerListModel = newsListModel;
        }else if([_columnInfoM.ColumnID intValue] == 11){
            [Utility sharedUtility].welfareListModel = newsListModel;
        }
        
        NSMutableArray * tempArr = [newsListModel.rows mutableCopy];
        __weak typeof (self) wealSelf = self;
        self.dataArr = [NSMutableArray array];
        [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx < 1) {
                NewsListInfo * newsList = obj;              
                [wealSelf.dataArr addObject:newsList];
            }
        }];
        [self.contentTableView reloadData];
        [self obtainCellHeight:self.dataArr ColmunId:_columnInfoM.ColumnID];
    } WithFaileBlock:^{
        
    }];
    NSParameterAssert(_columnInfoM);
    [newsVM fatchNewsInfoID:[NSString stringWithFormat:@"%@",_columnInfoM.ColumnID] pageSize:1 numberOfPage:1];
}

-(NSUInteger)obtainCellHeight:(NSArray *)arr ColmunId:(NSNumber *)Id{
    NSInteger cellHeight= 40;
    for (NewsListInfo * newsList in arr) {
        if ([newsList.Seat intValue] == 1 || [newsList.Seat intValue] == 4) {
            cellHeight += 140;
        }else{
            cellHeight += 90;
        }
    }
    if (self.activityContentTableViewHeight) {
        self.activityContentTableViewHeight(cellHeight, Id);
    }
    return cellHeight;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
