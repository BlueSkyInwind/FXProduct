//
//  MyCollectViewController.m
//  fengxianProduct
//
//  Created by admin on 2017/6/22.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MyCollectViewController.h"
#import "MoreViewModel.h"
#import "CollectModel.h"
#import "MyCollectTableViewCell.h"
#import "PhotoViewController.h"
#import "DetailViewController.h"
@interface MyCollectViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray * dataArr;
    
    int  pages;
    CollectDetailModel * collectDetailModel;
    CollectModel * collectModel;;
}
@property (nonatomic,strong)UITableView * tableView;

@end

@implementation MyCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的收藏";
    [self addBackItem];
    dataArr = [NSMutableArray array];
    [self configureView];
    [self requestCollectListInfo];
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyCollectTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyCollectTableViewCell"];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     NewsListInfo * newsListInfo = dataArr[indexPath.row];
    if ([newsListInfo.Seat intValue] == 1) {
        return 180;
    }else if ([newsListInfo.Seat intValue] == 4){
        return 180;
    }
    return 130;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsListInfo * newsListInfo = dataArr[indexPath.row];
    MyCollectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyCollectTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[MyCollectTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyCollectTableViewCell"];
    }
    cell.newsListInfo = newsListInfo;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     CollectDetailModel * collectDetailM  = dataArr[indexPath.row];
    if ([collectDetailM.Species integerValue] == 2) {
        PhotoViewController *photoVC = [[PhotoViewController alloc]init];
        photoVC.detailID = collectDetailM.ID;
        photoVC.Species =  collectDetailM.Species;
        [self.navigationController pushViewController:photoVC animated:YES];
    }else{
        DetailViewController *detailVC = [[DetailViewController alloc]init];
        detailVC.detailID = collectDetailM.ID;
        detailVC.Species =  collectDetailM.Species;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

-(void)requestCollectListInfo{
    MoreViewModel * moreViewModel = [[MoreViewModel alloc]init];
    [moreViewModel setBlockWithReturnBlock:^(id returnValue) {
        collectModel = returnValue;
        if (pages == 1) {
            [dataArr removeAllObjects];
        }
        NSMutableArray * tempArr = [collectModel.rows mutableCopy];
        [dataArr addObjectsFromArray:tempArr];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } WithFaileBlock:^{
        
    }];
    [moreViewModel fatchUserCollectInfo:@"3" pageSize:pages];
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
    [self requestCollectListInfo];
    
}

-(void)footerRereshing
{
    if ([collectModel.Next intValue] == 1) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"以显示全部内容"];
        [self.tableView.mj_footer endRefreshing];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
    });
    pages += 1;
    [self requestCollectListInfo];
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
