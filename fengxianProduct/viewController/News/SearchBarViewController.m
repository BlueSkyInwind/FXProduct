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

#define searchBarWidth 0.79

@interface SearchBarViewController ()<UISearchControllerDelegate,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UINavigationControllerDelegate,CAAnimationDelegate>{
    
    NSMutableArray * resultArray;
    
    NSMutableArray * historyArray;
    
    NSString * keyWord;
    
    NSMutableArray * dataArr;
    int  pages;
    NewsListModel * newsListModel;

    NSString * searchContentStr;
}
@property (nonatomic,strong) UISearchBar * searchBar;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UISearchController * searchController;


@end

@implementation SearchBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackItem];
    pages = 1;
    resultArray = [NSMutableArray array];
    dataArr = [NSMutableArray array];
    //搜索历史的加载
    
    [self configureView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;

    _tableView.tableFooterView.hidden = NO;
    if (historyArray.count == 0 || !historyArray) {
        
        _tableView.tableFooterView.hidden = YES;
        
    }
//    _searchController.active = NO;
    [resultArray removeAllObjects];
    [_tableView reloadData];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //保存搜索历史

}
-(void)configureView{
    

    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen  mainScreen].bounds.size.width ,[UIScreen  mainScreen].bounds.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTwoTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsMultipleTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsMultipleTableViewCell"];
    
//    self.searchFooterView = [[[NSBundle mainBundle]loadNibNamed:@"SearchFooterView" owner:nil options:nil]firstObject];
    
    //创建UISearchController
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    //设置代理
    _searchController.delegate = self;
    _searchController.searchResultsUpdater= self;
    
    //设置UISearchController的显示属性，以下3个属性默认为YES
    //搜索时，背景变暗色
    _searchController.dimsBackgroundDuringPresentation = NO;
    //搜索时，背景变模糊
//    _searchController.obscuresBackgroundDuringPresentation = NO;
    //隐藏导航栏
    _searchController.hidesNavigationBarDuringPresentation = NO;
    
    _searchController.searchBar.frame = CGRectMake(0 , 0 , _k_w * searchBarWidth, 44.0);
    _searchController.searchBar.barTintColor = UI_MAIN_COLOR;
    _searchController.searchBar.placeholder = @"请输入搜索内容";
    _searchController.searchBar.showsCancelButton = YES;
    _searchController.searchBar.delegate = self;
    UIButton *cancleBtn = [_searchController.searchBar valueForKey:@"cancelButton"];
    
    //修改标题和标题颜色
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // 添加 searchbar 到 headerview
    self.navigationItem.titleView = _searchController.searchBar;
    [self.view addSubview:_tableView];
    
}
-(void)clearSearchHistory{
    
    [historyArray removeAllObjects];
    [_tableView reloadData];
    _tableView.tableHeaderView.hidden = YES;
    //清楚缓存
}
-(void)cancelClick{
    
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger number;
    if (_searchController.active) {
        number = resultArray.count;
    }else{
        number = historyArray.count;
    }
    return number;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
#pragma mark - UITableViewDatasource
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_searchController.active) {
        

        
    }
    
    _searchController.active = NO;
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
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
    
}
#pragma mark - UISearchResultsUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSLog(@"updateSearchResultsForSearchController");
    //搜索结果的检验
    NSString * searchString = [[self.searchController.searchBar text] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([searchString isEqualToString:@""]){
        return;
    }
    //搜索网络请求
    [self requestNewsListInfo:searchString];
//    _searchController.active = NO;

}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    


}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    _searchController.active =NO;
    _tableView.tableFooterView.hidden = NO;
    [resultArray removeAllObjects];
    [_tableView reloadData];
}

#pragma mark - 数据请求

-(void)requestNewsListInfo:(NSString *)searchStr{
    NewsViewModel * newsVM = [[NewsViewModel alloc]init];
    [newsVM setBlockWithReturnBlock:^(id returnValue) {
        newsListModel = returnValue;
        if ([newsListModel.Next integerValue] == 1) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"以显示全部内容"];
        }
        searchContentStr = searchStr;
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
    [newsVM fatchNewsInfoSearchContent:searchStr pageSize:pages numberOfPage:10];
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
    [self requestNewsListInfo:searchContentStr];
    
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
