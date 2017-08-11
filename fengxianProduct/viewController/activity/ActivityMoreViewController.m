//
//  ActivityMoreViewController.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/29.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ActivityMoreViewController.h"
#import "NewsTableViewCell.h"
#import "MJRefresh.h"
#import "NewsViewModel.h"
#import "NewsListModel.h"
#import "DetailViewController.h"
#import "PhotoViewController.h"
#import "ActivityViewModel.h"
#import "VoteDetailFirstViewController.h"
#import "AnswerDetailViewController.h"
@interface ActivityMoreViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray * dataArr;
    
    int  pages;
    NewsListModel * newsListModel;
}
@property (nonatomic,strong)UITableView * tableView;

@end

@implementation ActivityMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = self.columnInfoModel.Title;
    [self addBackItem];
    pages = 1;
    dataArr = [NSMutableArray array];
    
    [self configureView];
    [self requestListData];
    [self setupMJRefreshTableView];
    
}
-(void)configureView{
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTwoTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsMultipleTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsMultipleTableViewCell"];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsListInfo * newsList = dataArr[indexPath.row];
    NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"NewsTableViewCell"];
    }
    //    [cell configureViewTitleImage:newsList.Image1 titleLabel:newsList.Title titleLocation:newsList.Source titleType:newsList.Column visitorNum:[NSString stringWithFormat:@"%@",newsList.Num] commentNum:[NSString stringWithFormat:@"%@",newsList.PLNum] imageType:[newsList.Species integerValue]];
    cell.newsList = newsList;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsListInfo * newsList = dataArr[indexPath.row];

    if (self.columnID == 9) {
        VoteDetailFirstViewController * voteDetailVC  = [[VoteDetailFirstViewController alloc]init];
        voteDetailVC.voteID = [NSString stringWithFormat:@"%@",newsList.ID];
        voteDetailVC.voteTitle = newsList.Title;
        [self.navigationController pushViewController:voteDetailVC animated:YES];
    }else if (self.columnID == 10){
        AnswerDetailViewController * answerDetailVC  = [[AnswerDetailViewController alloc]init];
        answerDetailVC.answerID = [NSString stringWithFormat:@"%@",newsList.ID];
        answerDetailVC.answerTitle = newsList.Title;
        [self.navigationController pushViewController:answerDetailVC animated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}
#pragma mark - 数据请求

-(void)requestListData{
    
    if (self.columnID == 9) {
        [self requestVoteListInfo];
    }else if (self.columnID == 10){
        [self requestAnswerListInfo];
    }
}

-(void)requestVoteListInfo{
    
    ActivityViewModel * activityVM = [[ActivityViewModel alloc]init];
    [activityVM setBlockWithReturnBlock:^(id returnValue) {
        //缓存数据
        newsListModel = returnValue;
        if (pages == 1) {
            [dataArr removeAllObjects];
        }
        NSMutableArray * tempArr = [newsListModel.rows mutableCopy];
        [dataArr addObjectsFromArray:tempArr];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } WithFaileBlock:^{
        
    }];
    [activityVM fatchVoteInfopageSize:1 numberOfPage:10];
}

-(void)requestAnswerListInfo{
    
    ActivityViewModel * activityVM = [[ActivityViewModel alloc]init];
    [activityVM setBlockWithReturnBlock:^(id returnValue) {
        //缓存数据
        newsListModel = returnValue;
        if (pages == 1) {
            [dataArr removeAllObjects];
        }
        NSMutableArray * tempArr = [newsListModel.rows mutableCopy];
        [dataArr addObjectsFromArray:tempArr];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } WithFaileBlock:^{
        
    }];
    [activityVM fatchAnswerInfopageSize:1 numberOfPage:10];
    
}
#pragma mark ----------设置列表的可刷新性----------
-(void)setupMJRefreshTableView
{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    //    header.automaticallyChangeAlpha = YES;
    //    [header beginRefreshing];
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    //    header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = footer;
    
}
-(void)headerRereshing
{
    //以下两种方法
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
    pages = 1;
    [self requestListData];

}

-(void)footerRereshing
{
    if ([newsListModel.Next intValue] == 1) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"已显示全部内容"];
        [self.tableView.mj_footer endRefreshing];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
    });
    pages += 1;
    [self requestListData];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
