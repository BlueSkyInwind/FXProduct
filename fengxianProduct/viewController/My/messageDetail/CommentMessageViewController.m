//
//  CommentMessageViewController.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/25.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "CommentMessageViewController.h"
#import "MoreViewModel.h"
#import "PhotoViewController.h"
#import "DetailViewController.h"
#import "CommentMessageModel.h"
#import "NewsViewModel.h"
#import "CommentMessageTableViewCell.h"
#import "CommentDetailViewController.h"

@interface CommentMessageViewController ()<UITableViewDelegate,UITableViewDataSource>{
    int  pages;
    
    CommentMessageModel * commentMessageModel;
    CommentMessageDetailModel * commentMessageDetailModel;
}
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,strong)NSMutableArray * deleteArr;
@end

@implementation CommentMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _isEdit = NO;
    _dataArr = [NSMutableArray array];
    _deleteArr = [NSMutableArray array];
    [self configureView];
    [self requestBrokeListInfo];
    [self setupMJRefreshTableView];
}
-(void)editCollectList{
    
    _isEdit = !_isEdit;
    [self.tableView reloadData];
    if (_isEdit) {
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
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentMessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommentMessageTableViewCell"];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 111;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentMessageDetailModel * commentMessageDetailM = _dataArr[indexPath.row];
    CommentMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommentMessageTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[CommentMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CommentMessageTableViewCell"];
    }
    cell.seletedDeleteBtn.tag = indexPath.row + 1000;
    cell.isDelete = _isEdit;
    cell.commentMessageDetailModel = commentMessageDetailM;
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
    
    CommentMessageDetailModel * commentMessageDetailM = _dataArr[indexPath.row];
    CommentDetailViewController * commentDetailVC = [[CommentDetailViewController alloc]init];
    commentDetailVC.detailID = commentMessageDetailM.ID;
    commentDetailVC.comID= commentMessageDetailM.ComID;
    [self.navigationController pushViewController:commentDetailVC animated:YES];
 
}

-(void)requestBrokeListInfo{
    MoreViewModel * moreViewModel = [[MoreViewModel alloc]init];
    [moreViewModel setBlockWithReturnBlock:^(id returnValue) {
        commentMessageModel = returnValue;
        if (pages == 1) {
            [_dataArr removeAllObjects];
        }
        NSMutableArray * tempArr = [commentMessageModel.rows mutableCopy];
        [_dataArr addObjectsFromArray:tempArr];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } WithFaileBlock:^{
        
    }];
    [moreViewModel fatchUserCommentMessageInfo:@"11" pageSize:pages];
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
    for (CommentMessageDetailModel * commentMessageDetailM in self.deleteArr) {
        
        deleteStr = [deleteStr stringByAppendingFormat:@"%@,",commentMessageDetailM.ID];
    }
    deleteStr = [deleteStr substringToIndex:deleteStr.length - 1];
    [newViewM fatchCollectAndSpotStatus:@"5" ceteID:deleteStr];
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
    if ([commentMessageModel.Next intValue] == 1) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"已显示全部内容"];
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
        make.height.equalTo(@50);
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
