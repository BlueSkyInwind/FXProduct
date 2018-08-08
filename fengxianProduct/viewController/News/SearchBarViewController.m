//
//  SearchBarViewController.m
//  TMHolterChildProject
//
//  Created by Wangyongxin on 16/6/14.
//  Copyright © 2016年 dk. All rights reserved.
//

#import "SearchBarViewController.h"
#import "NewsTwoTableViewCell.h"
#import "NewsMultipleTableViewCell.h"
#import "NewsTableViewCell.h"
#import "NewsListModel.h"
#import "NewsViewModel.h"
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "DataWriteAndRead.h"
#import "ClearSearchHistoryView.h"
#import "SearchHistoryTableViewCell.h"
#import "PhotoViewController.h"
#import "DetailViewController.h"
#define searchBarWidth 0.79

@interface SearchBarViewController ()<UISearchControllerDelegate,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UINavigationControllerDelegate,CAAnimationDelegate>{
    NSMutableArray * historyArray;
    NSMutableArray * dataArr;
    int  pages;
    NewsListModel * newsListModel;
    NSString * searchContentStr;
    
    BOOL isDisplayHistory;
    CGFloat tableViewHeight;
    
    MJRefreshNormalHeader *header;
    MJRefreshAutoNormalFooter *footer;
}
@property (nonatomic,strong) UISearchBar * searchBar;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UISearchController * searchController;
@property (nonatomic,strong) ClearSearchHistoryView * ClearSearchHV;

@end

@implementation SearchBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"搜索";
    [self addBackItem];
    pages = 1;
    isDisplayHistory = YES;
    tableViewHeight = 40;
    [self loadSearchHistory];
    dataArr = [NSMutableArray array];
    //搜索历史的加载
    [self configureView];
    [self setupMJRefreshTableView];
}
-(void)loadSearchHistory{
    
    //搜索历史的加载
    if ([DataWriteAndRead readDataWithkey:FX_SearchHistory]) {
        historyArray = [DataWriteAndRead readDataWithkey:FX_SearchHistory];
    }else{
        historyArray = [NSMutableArray array];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    if (historyArray.count == 0 || !historyArray || !historyArray.count) {
        tableViewHeight = 0;
    }
    [self.tableView reloadData];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //保存搜索历史
    [DataWriteAndRead writeDataWithkey:FX_SearchHistory value:historyArray];
}

-(void)configureView{
    
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen  mainScreen].bounds.size.width ,[UIScreen  mainScreen].bounds.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];

//    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTwoTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsMultipleTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsMultipleTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchHistoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"SearchHistoryTableViewCell"];
//    self.searchFooterView = [[[NSBundle mainBundle]loadNibNamed:@"SearchFooterView" owner:nil options:nil]firstObject];
    
    //创建UISearchController
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    //设置代理
    _searchController.delegate = self;
    _searchController.searchResultsUpdater= self;
    
    //设置UISearchController的显示属性，以下3个属性默认为YES
    //搜索时，背景变暗色
    _searchController.dimsBackgroundDuringPresentation = YES;
    //搜索时，背景变模糊
//    _searchController.obscuresBackgroundDuringPresentation = NO;
    //隐藏导航栏
    _searchController.hidesNavigationBarDuringPresentation = NO;
    
    _searchController.searchBar.frame = CGRectMake(0 , 0 , _k_w * searchBarWidth, 44.0);
    _searchController.searchBar.barTintColor = [UIColor whiteColor];
    _searchController.searchBar.placeholder = @"请输入搜索内容";
    _searchController.searchBar.showsCancelButton = YES;
    _searchController.searchBar.delegate = self;
    UIButton *cancleBtn = [_searchController.searchBar valueForKey:@"cancelButton"];

    //修改标题和标题颜色
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // 添加 searchbar 到 headerview
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.contentInset = UIEdgeInsetsMake(132, 0, 0, 0);
        UIView *searchBarTextField = [_searchController.searchBar.subviews.firstObject subviews][1];
        [searchBarTextField subviews].firstObject.backgroundColor = [UIColor whiteColor];
        searchBarTextField.layer.cornerRadius = 5;
        searchBarTextField.clipsToBounds = true;
        self.navigationItem.searchController = _searchController;
        self.navigationItem.hidesSearchBarWhenScrolling = false;
    }else{
        self.navigationItem.titleView = _searchController.searchBar;
    }
    [self.view addSubview:_tableView];
    
}

-(void)clearSearchHistory{
    [historyArray removeAllObjects];
    tableViewHeight = 0;
    [_tableView reloadData];
    //清楚缓存
    [DataWriteAndRead removeDataWithKey:FX_SearchHistory];
}

#pragma mark - tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger number;
    if (isDisplayHistory) {
        number = historyArray.count;
    }else{
        number = dataArr.count;
    }
    return number;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (isDisplayHistory) {
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        SearchHistoryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SearchHistoryTableViewCell" forIndexPath:indexPath];
        cell.contentLabel.text = historyArray[indexPath.row];
        return cell;
    }
    
    NewsListInfo * newsList = dataArr[indexPath.row];
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
#pragma mark - UITableViewDatasource
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (isDisplayHistory) {
        isDisplayHistory= NO;
        searchContentStr = historyArray[indexPath.row];
        [header beginRefreshing];
    }else{
        //数据点击
        NewsListInfo * newsList = dataArr[indexPath.row];
        if ([newsList.Species integerValue] == 2) {
            PhotoViewController *photoVC = [[PhotoViewController alloc]init];
            photoVC.detailID = newsList.ID;
            photoVC.Species =  newsList.Species;
            [self.navigationController pushViewController:photoVC animated:YES];
        }else{
            DetailViewController *detailVC = [[DetailViewController alloc]init];
            detailVC.detailID = newsList.ID;
            detailVC.Species =  newsList.Species;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isDisplayHistory) {
        return 40;
    }
    NewsListInfo * newsList = dataArr[indexPath.row];
    if ([newsList.Seat intValue] == 1) {
        return 140;
    }else if ([newsList.Seat intValue] == 4){
        return 140;
    }
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return tableViewHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
        self.ClearSearchHV = [[NSBundle mainBundle]loadNibNamed:@"ClearSearchHistoryView" owner:self options:nil].lastObject;
    __weak typeof (self) weakSelf = self;
    self.ClearSearchHV.deleteSearchHistory = ^(UIButton *button) {
        [weakSelf clearSearchHistory];
    };
    [view addSubview:self.ClearSearchHV];
    [self.ClearSearchHV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    return view;
}

#pragma mark - UISearchResultsUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSLog(@"updateSearchResultsForSearchController");
    //搜索结果的检验
    searchContentStr = [[self.searchController.searchBar text] stringByReplacingOccurrencesOfString:@" " withString:@""];
 
//    _searchController.active = NO;

}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    if ([searchContentStr isEqualToString:@""]){
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入搜索关键字"];
        return;
    }
    [historyArray addObject:searchContentStr];
    //搜索网络请求
    [self requestNewsListInfo:searchContentStr];

}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    isDisplayHistory = YES;
    tableViewHeight = 40;
    [_tableView reloadData];
}

#pragma mark - 数据请求

-(void)requestNewsListInfo:(NSString *)searchStr{
    NewsViewModel * newsVM = [[NewsViewModel alloc]init];
    [newsVM setBlockWithReturnBlock:^(id returnValue) {
        newsListModel = returnValue;
        if ([newsListModel.Next integerValue] == 1) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"已显示全部内容"];
        }
        isDisplayHistory = NO;
        if (pages == 1) {
            [dataArr removeAllObjects];
        }
        isDisplayHistory = NO;
        tableViewHeight = 0;
        NSMutableArray * tempArr = [newsListModel.rows mutableCopy];
        [dataArr addObjectsFromArray:tempArr];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } WithFaileBlock:^{
        
    }];
    [newsVM fatchNewsInfoSearchContent:searchStr pageSize:pages numberOfPage:10];
}

#pragma mark ----------设置列表的可刷新性----------
-(void)setupMJRefreshTableView
{
    
    header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    header.automaticallyChangeAlpha = YES;
    //    [header beginRefreshing];
    self.tableView.mj_header = header;
    
    footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    footer.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = footer;
    
}
-(void)headerRereshing
{
    if (isDisplayHistory) {
        [self.tableView.mj_header endRefreshing];
        return;
    }
    //以下两种方法
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
    pages = 1;
    [self requestNewsListInfo:searchContentStr];
    
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
    [self requestNewsListInfo:searchContentStr];
}
#pragma mark -UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
//    if (operation == UINavigationControllerOperationPush) {
//        //返回我们自定义的效果
//        CATransition *transition = [CATransition animation];
//        
//        transition.duration = 0.3f;
//        
//        transition.timingFunction = [CAMediaTiming FunctionfunctionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        
//        transition.type = kCATransitionPush;
//        
//        transition.subtype = kCATransitionFromRight;
//        
//        transition.delegate = self;
//        
//        [self.view.layer addAnimation:transition forKey:nil];
//        
//    }
//    else if (operation == UINavigationControllerOperationPop){
////        return [[PopTransition alloc]init];
//        CATransition *transition = [CATransition animation];
//        
//        transition.duration = 0.3f;
//        
//        transition.timingFunction = [CAMediaTiming FunctionfunctionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        
//        transition.type = kCATransitionPush;
//        
//        transition.subtype = kCATransitionFromLeft;
//        
//        transition.delegate = self;
//        
//        [self.view.superview.layer addAnimation:transition forKey:nil];
//        
//        [self.view removeFromSuperview];
//    }
    //返回nil则使用默认的动画效果
    return nil;
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
