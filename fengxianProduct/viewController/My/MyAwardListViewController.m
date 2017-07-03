//
//  MyAwardListViewController.m
//  fengxianProduct
//
//  Created by admin on 2017/7/3.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MyAwardListViewController.h"
#import "MyIntegralListTableViewCell.h"
#import "MyAwardListModel.h"
#import "IntegralViewModel.h"
#import "MyAwardListTableViewCell.h"

@interface MyAwardListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray * dataArr;
    MyAwardListModel * myAwardListModel;
    int  pages;
    
}
@property (nonatomic,strong)UITableView * tableView;

@end

@implementation MyAwardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的奖品";
    [self addBackItem];
    self.view.backgroundColor = [UIColor redColor];
    pages = 1;
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
    //    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyAwardListTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyAwardListTableViewCell"];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   MyAwardDetailListModel * myAwardDetailListModel = dataArr[indexPath.row];
    MyAwardListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyAwardListTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[MyAwardListTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyAwardListTableViewCell"];
    }
    cell.myAwardDetailListModel = myAwardDetailListModel;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
    
}
#pragma mark - 数据请求

-(void)requestNewsListInfo{
    
    IntegralViewModel * integralViewM = [[IntegralViewModel alloc]init];
    [integralViewM setBlockWithReturnBlock:^(id returnValue) {
        myAwardListModel = returnValue;
        if (pages == 1) {
            [dataArr removeAllObjects];
        }
        NSMutableArray * tempArr = [myAwardListModel.rows mutableCopy];
        [dataArr addObjectsFromArray:tempArr];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } WithFaileBlock:^{
        
    }];
    [integralViewM fatchUserAwardListInfo:@"10" pageSize:pages];
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
    [self requestNewsListInfo];
    
}

-(void)footerRereshing
{
    if ([myAwardListModel.Next intValue] == 1) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"以显示全部内容"];
        [self.tableView.mj_footer endRefreshing];
    }
    
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
