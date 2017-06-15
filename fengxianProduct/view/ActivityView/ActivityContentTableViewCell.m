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
@implementation ActivityContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [Tool setCornerWithoutRadius:self.backView borderColor:[UIColor grayColor]];
    self.updateListNumLabel.layer.cornerRadius = self.updateListNumLabel.frame.size.width;
    self.updateListNumLabel.clipsToBounds = YES;
    self.updateListNumLabel.hidden = YES;
    [self.moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [self configureView];
}

-(void)configureView{
    
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    self.contentTableView.backgroundColor = [UIColor whiteColor];
    self.contentTableView.scrollEnabled = NO;
//    self.contentTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    
    [self.contentTableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTableViewCell"];
    [self.contentTableView registerNib:[UINib nibWithNibName:@"NewsTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTwoTableViewCell"];
    [self.contentTableView registerNib:[UINib nibWithNibName:@"NewsMultipleTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsMultipleTableViewCell"];
//    [self requestNewsListInfo];
}

- (IBAction)moreBtnClick:(id)sender {
    
    if (self.moreButtonCilck) {
        self.moreButtonCilck(sender);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsListInfo * newsList = self.dataArr[indexPath.row];
    if ([newsList.Seat intValue] == 1) {
        return 140;
    }else if ([newsList.Seat intValue] == 4){
        return 140;
    }
    return 90;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
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
    
    
}
-(void)setColumnInfoM:(ColumnInfoModel *)columnInfoM{
    _columnInfoM= nil;
    _columnInfoM = columnInfoM;
    self.titleLabel.text = columnInfoM.Title;
    
    //缓存数据
    if ([_columnInfoM.ColumnID intValue] == 8) {
        return;
    }else if([_columnInfoM.ColumnID intValue] == 9){
        self.dataArr =  [[Utility sharedUtility].voteListModel.rows mutableCopy];
    }else if([_columnInfoM.ColumnID intValue] == 10){
        self.dataArr =  [[Utility sharedUtility].answerListModel.rows mutableCopy];
    }else if([_columnInfoM.ColumnID intValue] ==11){
        self.dataArr =  [[Utility sharedUtility].welfareListModel.rows mutableCopy];
    }
    [self requestNewsListInfo];
}
#pragma mrak - 数据请求
-(void)requestNewsListInfo{
    if (self.dataArr) {
        [self.contentTableView reloadData];
        [self obtainCellHeight:self.dataArr];
        return;
    }
    NewsViewModel * newsVM = [[NewsViewModel alloc]init];
    [newsVM setBlockWithReturnBlock:^(id returnValue) {
        
        //缓存数据
        NewsListModel * newsListModel = returnValue;
        if ([_columnInfoM.ColumnID intValue] == 8) {
            
        }else if([_columnInfoM.ColumnID intValue] == 9){
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
            if (idx < 3) {
                NewsListInfo * newsList = obj;
                [wealSelf.dataArr addObject:newsList];
                [self.contentTableView reloadData];
                [self obtainCellHeight:self.dataArr];
            }
        }];
    } WithFaileBlock:^{
        
    }];
    NSParameterAssert(_columnInfoM);
    [newsVM fatchNewsInfoID:[NSString stringWithFormat:@"%@",_columnInfoM.ColumnID] pageSize:1 numberOfPage:1];
}

-(NSUInteger)obtainCellHeight:(NSArray *)arr{
    NSInteger cellHeight= 40;
    for (NewsListInfo * newsList in arr) {
        if ([newsList.Seat intValue] == 1 || [newsList.Seat intValue] == 4) {
            cellHeight += 140;
        }else{
            cellHeight += 90;
        }
    }
    if (self.activityContentTableViewHeight) {
        self.activityContentTableViewHeight(cellHeight);
    }
    return cellHeight;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end