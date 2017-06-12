//
//  HomePageViewController.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/11.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "HomePageViewController.h"
#import "NewsTableViewCell.h"
#import "MJRefresh.h"
#import "NewsViewModel.h"
#import "NewsListModel.h"
#import "JZLCycleView.h"
#import "BannerViewModel.h"
#import "BannerInfoModel.h"
#import "NewsTwoTableViewCell.h"
#import "NewsMultipleTableViewCell.h"

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource,JZLCycleViewDelegate>{
    NSMutableArray * dataArr;
    NSMutableArray * bannerArr;

    int  pages;
    
    NewsListModel * newsListModel;
    
}

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)JZLCycleView * cycleView;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    pages = 1;
    dataArr = [NSMutableArray array];
    bannerArr = [NSMutableArray array];

    [self configureView];
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
    if (indexPath.section == 0) {
        return 150;
    }else{
        NewsListInfo * newsList = dataArr[indexPath.row];
        if ([newsList.Seat intValue] == 1) {
            return 140;
        }else if ([newsList.Seat intValue] == 4){
            return 140;
        }
        return 90;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        return dataArr.count;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LoginOutCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LoginOutCell"];
        }
        _cycleView = [JZLCycleView cycleCollectionViewWithFrame:CGRectMake(0, 0, _k_w, 150) imageArray:bannerArr PlaceholderImage:[UIImage imageNamed:@"user_Icon"]];
        _cycleView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _cycleView.pageControl.currentPageIndicatorTintColor = UI_MAIN_COLOR;
        _cycleView.delegate = self;
        [cell addSubview:_cycleView];
        return cell;
    }
    
    NewsListInfo * newsList = dataArr[indexPath.row];
    if ([newsList.Seat intValue] == 1) {
        NewsMultipleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsMultipleTableViewCell" forIndexPath:indexPath];
        cell.newsList = newsList;

//        [cell configureViewTitleImageOne:newsList.Image1 ImageTwo:newsList.Image2 ImageThree:newsList.Image3 titleLabel:newsList.Title titleLocation:newsList.Source titleType:newsList.Column visitorNum:[NSString stringWithFormat:@"%@",newsList.Num] commentNum:[NSString stringWithFormat:@"%@",newsList.PLNum] imageType:[newsList.Species integerValue]];
        return cell;
    }else if ([newsList.Seat intValue] == 4){
        
        NewsTwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsTwoTableViewCell" forIndexPath:indexPath];
        cell.newsList = newsList;

//        [cell configureViewTitleImageOne:newsList.Image1 ImageTwo:newsList.Image2 titleLabel:newsList.Title titleLocation:newsList.Source titleType:newsList.Column visitorNum:[NSString stringWithFormat:@"%@",newsList.Num] commentNum:[NSString stringWithFormat:@"%@",newsList.PLNum] imageType:[newsList.Species integerValue]];
        return cell;
    }
    
    NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"NewsTableViewCell"];
    }
//    [cell configureViewTitleImage:newsList.Image1 titleLabel:newsList.Title titleLocation:newsList.Source titleType:newsList.Column visitorNum:[NSString stringWithFormat:@"%@",newsList.Num] commentNum:[NSString stringWithFormat:@"%@",newsList.PLNum] imageType:[newsList.Species integerValue]];
    cell.newsList = newsList;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
#pragma mark - 录播图点击
//代理跳转
- (void)selectItemAtIndex:(NSInteger)index {
    NSLog(@"%ld",index);
    
}
#pragma mark - 数据请求

-(void)requestNewsListInfo{
    NewsViewModel * newsVM = [[NewsViewModel alloc]init];
    [newsVM setBlockWithReturnBlock:^(id returnValue) {
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
    [newsVM fatchNewsInfoID:@"0" pageSize:pages numberOfPage:10];
}
-(void)requestBannerInfo{
    BannerViewModel * bannerVM = [[BannerViewModel alloc]init];
    [bannerVM setBlockWithReturnBlock:^(id returnValue) {
       
        BannerListModel * bannerList  = returnValue;
        bannerArr = [bannerList.rows mutableCopy];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } WithFaileBlock:^{
        
    }];
    [bannerVM fatchBannerInfoID:@"1"];
}
#pragma mark ----------设置列表的可刷新性----------
-(void)setupMJRefreshTableView
{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
//    header.automaticallyChangeAlpha = YES;
    [header beginRefreshing];
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
    [self requestBannerInfo];

}

-(void)footerRereshing
{
    if ([newsListModel.Next intValue] == 1) {
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
