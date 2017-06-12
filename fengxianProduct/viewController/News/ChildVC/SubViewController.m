//
//  SubViewController.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/11.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "SubViewController.h"
#import "NewsTableViewCell.h"
#import "MJRefresh.h"
#import "NewsViewModel.h"
#import "NewsListModel.h"
#import "JZLCycleView.h"
#import "NewsTwoTableViewCell.h"
#import "NewsMultipleTableViewCell.h"

@interface SubViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray * dataArr;
    
    int  pages;
}
@property (nonatomic,strong)UITableView * tableView;

@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    pages = 0;
    dataArr = [NSMutableArray array];
    
    [self configureView];
    [self requestNewsListInfo];
    [self setupMJRefreshTableView];
    
}
-(void)configureView{
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTwoTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsMultipleTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsMultipleTableViewCell"];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsListInfo * newsList = dataArr[indexPath.row];
    if ([newsList.Seat intValue] == 1) {
        return 140;
    }else if ([newsList.Seat intValue] == 4){
        return 140;
    }
    return 90;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsListInfo * newsList = dataArr[indexPath.row];
    if ([newsList.Seat intValue] == 1) {
        NewsMultipleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsMultipleTableViewCell" forIndexPath:indexPath];
        [cell configureViewTitleImageOne:newsList.Image1 ImageTwo:newsList.Image2 ImageThree:newsList.Image3 titleLabel:newsList.Title titleLocation:newsList.Source titleType:newsList.Column visitorNum:[NSString stringWithFormat:@"%@",newsList.Num] commentNum:[NSString stringWithFormat:@"%@",newsList.PLNum] imageType:[newsList.Species integerValue]];
        return cell;
    }else if ([newsList.Seat intValue] == 4){
        
        NewsTwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsTwoTableViewCell" forIndexPath:indexPath];
        [cell configureViewTitleImageOne:newsList.Image1 ImageTwo:newsList.Image2 titleLabel:newsList.Title titleLocation:newsList.Source titleType:newsList.Column visitorNum:[NSString stringWithFormat:@"%@",newsList.Num] commentNum:[NSString stringWithFormat:@"%@",newsList.PLNum] imageType:[newsList.Species integerValue]];
        return cell;
    }
    NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"NewsTableViewCell"];
    }
    [cell configureViewTitleImage:newsList.Image1 titleLabel:newsList.Title titleLocation:newsList.Source titleType:newsList.Column visitorNum:[NSString stringWithFormat:@"%@",newsList.Num] commentNum:[NSString stringWithFormat:@"%@",newsList.PLNum] imageType:[newsList.Species integerValue]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
#pragma mark - 数据请求

-(void)requestNewsListInfo{
    NewsViewModel * newsVM = [[NewsViewModel alloc]init];
    [newsVM setBlockWithReturnBlock:^(id returnValue) {
        NewsListModel * newsListModel = returnValue;
        if ([newsListModel.Next integerValue] == 1) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"以显示全部内容"];
        }
        NSMutableArray * tempArr = [newsListModel.rows mutableCopy];
        dataArr = [[dataArr arrayByAddingObjectsFromArray:tempArr] mutableCopy];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } WithFaileBlock:^{
        
    }];
    [newsVM fatchNewsInfoID:[NSString stringWithFormat:@"%ld",(long)self.columnID] pageSize:pages numberOfPage:10];
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
    pages = 0;
    [self requestNewsListInfo];
    
}

-(void)footerRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
    });
    pages += 1;
    [self requestNewsListInfo];
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
