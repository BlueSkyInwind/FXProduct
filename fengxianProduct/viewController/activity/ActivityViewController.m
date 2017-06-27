 //
//  ActivityViewController.m
//  fengxianProduct
//
//  Created by admin on 2017/6/6.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ActivityViewController.h"
#import "MJRefresh.h"
#import "NewsViewModel.h"
#import "NewsListModel.h"
#import "JZLCycleView.h"
#import "BannerViewModel.h"
#import "BannerInfoModel.h"
#import "ActivityContentTableViewCell.h"
#import "ActivityBrokeViewTableViewCell.h"
#import "LiveMoreViewController.h"

@interface ActivityViewController ()<UITableViewDelegate,UITableViewDataSource,JZLCycleViewDelegate,WriteInfoViewDelegate>{
    
    NSMutableArray * dataArr;
    NSMutableArray * bannerArr;
    NSMutableArray * columnInfoArr;
    
    NewsListModel * newsListModel;
    
    NSInteger VoteCellheight;
    NSInteger answerCellheight;
    NSInteger welfareCellheight;

    NSInteger baoliaoCellheight;

    NSInteger  tableViewHeight;


}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)JZLCycleView * cycleView;
//@property (nonatomic,strong)ActivityContentTableViewCell * cell;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    dataArr = [NSMutableArray array];
    [self getColumnData];
    bannerArr = [NSMutableArray array];
    VoteCellheight = 40;
    answerCellheight = 40;
    welfareCellheight = 40;

    baoliaoCellheight = 260;
    tableViewHeight = 160;
    if (UI_IS_IPHONE6) {
        tableViewHeight = 200;
    }
    [self configureView];
    [self setupMJRefreshTableView];
}
-(void)getColumnData{
    if ([Utility sharedUtility].acticityColumnModel.rows ) {
        [[Utility sharedUtility].acticityColumnModel.rows enumerateObjectsUsingBlock:^(ColumnInfoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
 
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityBrokeViewTableViewCell" bundle:nil] forCellReuseIdentifier:@"ActivityBrokeViewTableViewCell"];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            if (UI_IS_IPHONE6) {
                return 200;
            }
            return 160;
        }
            break;
        case 1:{
            if (indexPath.row == 0) {
                return baoliaoCellheight;
            }else if (indexPath.row == 1){
                return VoteCellheight;
            }else if (indexPath.row == 2){
                return answerCellheight;
            }else if (indexPath.row == 3){
                return welfareCellheight;
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
        _cycleView = [JZLCycleView cycleCollectionViewWithFrame:CGRectMake(0, 0, _k_w, tableViewHeight) imageArray:bannerArr PlaceholderImage:[UIImage imageNamed:@"banner_placeholder_Icon"]];
        _cycleView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _cycleView.pageControl.currentPageIndicatorTintColor = UI_MAIN_COLOR;
        _cycleView.delegate = self;
        [cell addSubview:_cycleView];
        return cell;
    }else{
        
        if (indexPath.row == 0) {
            ActivityBrokeViewTableViewCell * firstCell = [tableView dequeueReusableCellWithIdentifier:@"ActivityBrokeViewTableViewCell" forIndexPath:indexPath];
            firstCell.columnInfoM = dataArr[indexPath.row];
            firstCell.vc = self;
            __weak typeof (self) weakSelf = self;
            firstCell.activityBrokeViewTableViewHeight = ^(NSInteger height) {
                baoliaoCellheight = height;
                [weakSelf.tableView beginUpdates];
                [weakSelf.tableView endUpdates];
            };
            return firstCell;
        }
        NSString * cellStr = [NSString stringWithFormat:@"ActivityContentTableViewCell%ld%ld",(long)indexPath.row,(long)indexPath.section];
        [self.tableView registerNib:[UINib nibWithNibName:@"ActivityContentTableViewCell" bundle:nil] forCellReuseIdentifier:cellStr];
        ActivityContentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr forIndexPath:indexPath];
        if (!cell) {
            cell = [[ActivityContentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        cell.currentVC = self;
        cell.dataArr = [columnInfoArr mutableCopy];
        cell.columnInfoM = dataArr[indexPath.row];
        cell.moreButtonCilck = ^(UIButton *button) {
            LiveMoreViewController * liveMoreVC = [[LiveMoreViewController alloc]init];
            ColumnInfoModel *columnInfoM = dataArr[indexPath.row - 1];
            liveMoreVC.columnID = [columnInfoM.ColumnID integerValue];
            liveMoreVC.columnInfoModel = columnInfoM;
            [self.navigationController pushViewController:liveMoreVC animated:YES];
        };
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}
#pragma mark - 录播图点击
//代理跳转
- (void)selectItemAtIndex:(NSInteger)index {
    NSLog(@"%ld",index);
    
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
    [bannerVM fatchBannerInfoID:@"3"];
}

-(void)requestVoteListInfo:(NSNumber *)Id{

    NewsViewModel * newsVM = [[NewsViewModel alloc]init];
    [newsVM setBlockWithReturnBlock:^(id returnValue) {
        //缓存数据
        NewsListModel * newsListM = returnValue;
        NSMutableArray * tempArr = [newsListM.rows mutableCopy];
        if (!tempArr || tempArr.count == 0 ) {
            VoteCellheight = 40;
        }else{
            VoteCellheight = 160;
        }
     
        __weak typeof (self) wealSelf = self;
        NewsListInfo * newsList = tempArr.firstObject;
        columnInfoArr = [NSMutableArray arrayWithObjects:newsList, nil];
        
        [Utility sharedUtility].voteListModel = newsListM;
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
        [wealSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
 
    } WithFaileBlock:^{
        
    }];
    [newsVM fatchNewsInfoID:[NSString stringWithFormat:@"%@",Id] pageSize:1 numberOfPage:1];
}
-(void)requestAnswerListInfo:(NSNumber *)Id{
    
    NewsViewModel * newsVM = [[NewsViewModel alloc]init];
    [newsVM setBlockWithReturnBlock:^(id returnValue) {
        //缓存数据
        NewsListModel * newsListM = returnValue;
        NSMutableArray * tempArr = [newsListM.rows mutableCopy];
        if (!tempArr || tempArr.count == 0 ) {
            answerCellheight = 40;
        }else{
            answerCellheight = 160;
        }
        
        __weak typeof (self) wealSelf = self;
        NewsListInfo * newsList = tempArr.firstObject;
        columnInfoArr = [NSMutableArray arrayWithObjects:newsList, nil];
        
        [Utility sharedUtility].answerListModel = newsListM;
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:2 inSection:1];
        [wealSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    } WithFaileBlock:^{
        
    }];
    [newsVM fatchNewsInfoID:[NSString stringWithFormat:@"%@",Id] pageSize:1 numberOfPage:1];
}
-(void)requestwelfareListInfo:(NSNumber *)Id{
    
    NewsViewModel * newsVM = [[NewsViewModel alloc]init];
    [newsVM setBlockWithReturnBlock:^(id returnValue) {
        //缓存数据
        NewsListModel * newsListM = returnValue;
        NSMutableArray * tempArr = [newsListM.rows mutableCopy];
        if (!tempArr || tempArr.count == 0 ) {
            welfareCellheight = 40;
        }else{
            welfareCellheight = 160;
        }
        __weak typeof (self) wealSelf = self;
        NewsListInfo * newsList = tempArr.firstObject;
        columnInfoArr = [NSMutableArray arrayWithObjects:newsList, nil];
        
        [Utility sharedUtility].welfareListModel = newsListM;
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:3 inSection:1];
        [wealSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } WithFaileBlock:^{
        
    }];
    [newsVM fatchNewsInfoID:[NSString stringWithFormat:@"%@",Id] pageSize:1 numberOfPage:1];
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
    [self requestVoteListInfo:@(9)];
    [self requestAnswerListInfo:@(10)];
    [self requestwelfareListInfo:@(11)];
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
