//
//  MyBrokeViewController.m
//  fengxianProduct
//
//  Created by admin on 2017/6/22.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MyBrokeViewController.h"
#import "MoreViewModel.h"
#import "MyBaoliaoTableViewCell.h"
#import "PhotoViewController.h"
#import "DetailViewController.h"
#import "MoreBottomDeleteView.h"
#import "NewsViewModel.h"
#import "BrokeModel.h"
@interface MyBrokeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    int  pages;
    BrokeModel * brokeModel;
    BrokeDetailModel * brokeDetailModel;
    
    BOOL isEdit;
}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)MoreBottomDeleteView * moreBottomDeleteV;
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,strong)NSMutableArray * deleteArr;
@end

@implementation MyBrokeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的爆料";
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editCollectList)];
    barBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = barBtn;
    [self addBackItem];
    isEdit = NO;
    _dataArr = [NSMutableArray array];
    _deleteArr = [NSMutableArray array];
    [self configureView];
    [self requestBrokeListInfo];
    [self setupMJRefreshTableView];
}
-(void)editCollectList{
    if (!_dataArr || _dataArr.count == 0) {
        return;
    }
    isEdit = !isEdit;
    [self.tableView reloadData];
    if (isEdit) {
        self.navigationItem.rightBarButtonItem.title = @"取消";
        [self showBottomDeleteView];
    }else{
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        [self removeBottomDeleteView];
    }
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyBaoliaoTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyBaoliaoTableViewCell"];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BrokeDetailModel * brokeDetailM = _dataArr[indexPath.row];
    MyBaoliaoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyBaoliaoTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[MyBaoliaoTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyBaoliaoTableViewCell"];
    }
    cell.SeletedDeleteBtn.tag = indexPath.row + 1000;
    cell.isDelete = isEdit;
    cell.brokeDetailModel = brokeDetailM;
    __weak typeof (self) weakSelf = self;
    cell.selectedBtn = ^(NSInteger num, BOOL isCan) {
        NewsListInfo * newsListI = weakSelf.dataArr[num - 1000];
        if (isCan) {
            [weakSelf.deleteArr addObject:newsListI];
        }else{
            [weakSelf.deleteArr removeObject:newsListI];
        }
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    CollectDetailModel * collectDetailM  = _dataArr[indexPath.row];
//    if ([collectDetailM.Species integerValue] == 2) {
//        PhotoViewController *photoVC = [[PhotoViewController alloc]init];
//        photoVC.detailID = collectDetailM.ID;
//        photoVC.Species =  collectDetailM.Species;
//        [self.navigationController pushViewController:photoVC animated:YES];
//    }else{
//        DetailViewController *detailVC = [[DetailViewController alloc]init];
//        detailVC.detailID = collectDetailM.ID;
//        detailVC.Species =  collectDetailM.Species;
//        [self.navigationController pushViewController:detailVC animated:YES];
//    }
}

-(void)requestBrokeListInfo{
    MoreViewModel * moreViewModel = [[MoreViewModel alloc]init];
    [moreViewModel setBlockWithReturnBlock:^(id returnValue) {
        brokeModel = returnValue;
        if (pages == 1) {
            [_dataArr removeAllObjects];
        }
        NSMutableArray * tempArr = [brokeModel.rows mutableCopy];
        [_dataArr addObjectsFromArray:tempArr];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } WithFaileBlock:^{
        
    }];
    [moreViewModel fatchUserBrokeInfoPageSize:pages];
}
-(void)requestDeleteCollect:(void(^)(BOOL isSuccess))finish{
    NewsViewModel * newViewM = [[NewsViewModel alloc]init];
    [newViewM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:(NSString *)returnMsg.msg];
            finish(YES);
        }
    } WithFaileBlock:^{
        
    }];
    NSString * deleteStr = @"";
    for (BrokeDetailModel * brokeDetailM in self.deleteArr) {
        
        deleteStr = [deleteStr stringByAppendingFormat:@"%@,",brokeDetailM.ID];
    }
    deleteStr = [deleteStr substringToIndex:deleteStr.length - 1];
    [newViewM fatchCollectAndSpotStatus:@"3" ceteID:deleteStr];
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
    [self requestBrokeListInfo];
    
}

-(void)footerRereshing
{
    if ([brokeModel.Next intValue] == 1) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"以显示全部内容"];
        [self.tableView.mj_footer endRefreshing];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
    });
    pages += 1;
    [self requestBrokeListInfo];
}
#pragma mark - buttonDeleteView
-(void)showBottomDeleteView{
    
    _moreBottomDeleteV =  [[NSBundle mainBundle]loadNibNamed:@"MoreBottomDeleteView" owner:self options:nil].lastObject;
    __weak typeof (self) weakSelf = self;
    _moreBottomDeleteV.bottomDeleteTap = ^(UITapGestureRecognizer *tap) {
        [weakSelf requestDeleteCollect:^(BOOL isSuccess) {
            [weakSelf.dataArr removeObjectsInArray:weakSelf.deleteArr];
            [weakSelf.tableView reloadData];
        }];
    };
    [self.view addSubview:_moreBottomDeleteV];
    [self.moreBottomDeleteV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@40);
    }];
}

-(void)removeBottomDeleteView{
    
    [_moreBottomDeleteV removeFromSuperview];
    _moreBottomDeleteV = nil;
    
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
