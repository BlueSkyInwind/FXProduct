//
//  LivesViewController.m
//  fengxianProduct
//
//  Created by admin on 2017/6/6.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "LivesViewController.h"
#import "MJRefresh.h"
#import "NewsViewModel.h"
#import "NewsListModel.h"
#import "JZLCycleView.h"
#import "BannerViewModel.h"
#import "BannerInfoModel.h"
#import "AddColumnTableViewCell.h"
#import "LivesContentTableViewCell.h"
#import "MyColumnViewController.h"
#import "LiveMoreViewController.h"
#import "PhotoViewController.h"
#import "DetailViewController.h"
#import "LiveViewModel.h"
#import "LiveMessageModel.h"

@interface LivesViewController ()<UITableViewDelegate,UITableViewDataSource,JZLCycleViewDelegate,AddColumnTableViewCellDelegate>{
    NSMutableArray * dataArr;
    NSMutableArray * bannerArr;
    NSMutableArray * badgeArr;

    NewsListModel * newsListModel;
    
    NSInteger  tableViewHeight;
    LiveMessageModel * liveMessageModel;
}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)JZLCycleView * cycleView;
@end

@implementation LivesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    dataArr = [NSMutableArray array];
    bannerArr = [NSMutableArray array];
    [self.tabBarController.tabBar.items objectAtIndex:1].badgeValue =nil;
    tableViewHeight = 160;
    if (UI_IS_IPHONE6) {
        tableViewHeight = 200;
    }
    
    [self getColumnData];
    
    [self configureView];
    [self setupMJRefreshTableView];
}

-(void)getColumnData{
    if ([Utility sharedUtility].livesColumnModel.rows ) {
        [[Utility sharedUtility].livesColumnModel.rows enumerateObjectsUsingBlock:^(ColumnInfoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ColumnInfoModel * infoModel = (ColumnInfoModel *)obj;
            if ([infoModel.According intValue] == 1) {
                [dataArr addObject:infoModel];
            }
        }];
    }
}
-(void)configureView{
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kUIColorFromRGB(0xe5e5e5);
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AddColumnTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddColumnTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LivesContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"LivesContentTableViewCell"];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            return tableViewHeight;
        }
            break;
        case 1:{
            if (indexPath.row == 0 ) {
                return 90;
            }else{
                return 320;
            }
        }
            break;
        default:
            break;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        return 1 + dataArr.count;
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
        _cycleView = [JZLCycleView cycleCollectionViewWithFrame:CGRectMake(0, 0, _k_w, tableViewHeight) imageArray:bannerArr PlaceholderImage:[UIImage imageNamed:@"banner_placeholder_Icon"]];
        _cycleView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _cycleView.pageControl.currentPageIndicatorTintColor = UI_MAIN_COLOR;
        _cycleView.delegate = self;
        [cell addSubview:_cycleView];
        return cell;
    }
    if (indexPath.row == 0) {
        AddColumnTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AddColumnTableViewCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.dataArr = dataArr;
        return cell;
    }else{
        
        LivesContentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LivesContentTableViewCell" forIndexPath:indexPath];
        if (badgeArr && badgeArr.count != 0) {
            cell.livebadgeModel = badgeArr[indexPath.row - 1];
        }
        cell.columnInfoM = dataArr[indexPath.row - 1];
        cell.currentVC = self;
        __weak typeof (self) weakSelf = self;
        cell.moreButtonCilck = ^(UIButton *button) {
            LiveMoreViewController * liveMoreVC = [[LiveMoreViewController alloc]init];
            ColumnInfoModel *columnInfoM = dataArr[indexPath.row - 1];
            liveMoreVC.columnID = [columnInfoM.ColumnID integerValue];
            liveMoreVC.columnInfoModel = columnInfoM;
            [self.navigationController pushViewController:liveMoreVC animated:YES];
        };
        cell.livesContentTableViewHeight  = ^(NSInteger height) {
            [weakSelf.tableView setRowHeight:height];
        };
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
}
#pragma mark - 录播图点击
//代理跳转
- (void)selectItemAtIndex:(NSInteger)index {
    NSLog(@"%ld",index);
    BannerInfoModel * bannerInfo = bannerArr[index];
    if ([bannerInfo.Type integerValue] == 2) {
        PhotoViewController *photoVC = [[PhotoViewController alloc]init];
        photoVC.detailID = bannerInfo.NewID;
        photoVC.Species =  bannerInfo.Type;
        [self.navigationController pushViewController:photoVC animated:YES];
    }else{
        DetailViewController *detailVC = [[DetailViewController alloc]init];
        detailVC.detailID = bannerInfo.NewID;
        detailVC.Species =  bannerInfo.Type;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}
#pragma mark - 数据请求

-(void)requestBannerInfo{
    BannerViewModel * bannerVM = [[BannerViewModel alloc]init];
    [bannerVM setBlockWithReturnBlock:^(id returnValue) {
        
        BannerListModel * bannerList  = returnValue;
        bannerArr = [bannerList.rows mutableCopy];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView.mj_header endRefreshing];
    } WithFaileBlock:^{
        
    }];
    [bannerVM fatchBannerInfoID:@"2"];
}
-(void)obtainColumnBadgeValue:(void(^)(BOOL isSuccess))finish{
    LiveViewModel * liveViewModel = [[LiveViewModel alloc]init];
    [liveViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        liveMessageModel = returnValue;
        badgeArr  = [liveMessageModel.news mutableCopy];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        finish(YES);
        
    } WithFaileBlock:^{
        
    }];
    [liveViewModel fatchLivesColumnBadgeValue];
}
-(void)columnViewOneTap{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}
-(void)columnViewTwoTap{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:1];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}
-(void)columnViewThreeTap{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:1];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}
-(void)columnViewFourTap{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:1];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}
-(void)editBottonCilck{
    
    if ([[ShareConfig share] isPresentLoginVC:self]) {
        MyColumnViewController * myColumnVC = [[MyColumnViewController alloc]init];
        myColumnVC.columnType = @"2";
        myColumnVC.dataArr =  [[Utility sharedUtility].livesColumnModel.rows mutableCopy];
        __weak typeof (self) weakSelf = self;
        myColumnVC.columnResult = ^(NSMutableArray *resultArr) {
            dataArr = resultArr;
            [weakSelf.tableView reloadData];
            [[ShareConfig share]obtainLivesColumnInfo];
        };
        [self.navigationController pushViewController:myColumnVC animated:YES];
    }
}
#pragma mark ----------设置列表的可刷新性----------
-(void)setupMJRefreshTableView
{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    //    header.automaticallyChangeAlpha = YES;
    [header beginRefreshing];
    self.tableView.mj_header = header;
}
-(void)headerRereshing
{
    //以下两种方法
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
    [self requestBannerInfo];
    [self obtainColumnBadgeValue:^(BOOL isSuccess) {
        
    }];

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
