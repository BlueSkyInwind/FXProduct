//
//  VoteDetailFirstViewController.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/29.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "VoteDetailFirstViewController.h"
#import "ActivityViewModel.h"
#import "VoteDetailModel.h"
#import "VoteFirstTableViewCell.h"
#import "VoteSecondCollectionViewCell.h"
#import "VoteThirdTableViewCell.h"
#import "VoteDetailView.h"
#import "VoteDetailSecondView.h"

@interface VoteDetailFirstViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    VoteDetailModel * voteDetailModel;

}
@property (nonatomic,strong)VoteDetailView * voteDetailView;
@property (nonatomic,strong)VoteDetailSecondView * voteDetailSecondView;

@property (nonatomic,strong)UITableView * tableView;
@end

@implementation VoteDetailFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.voteTitle;
    [self addBackItem];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    __weak typeof (self) weakSelf = self;
    [self requestAnswerListInfo:^(BOOL isSuccess) {
        [weakSelf configureView];
    }];
}
-(void)configureView{
    
    if ([voteDetailModel.Type integerValue] == 1) {
        [self addVoteDetailView:voteDetailModel];
    }else if ([voteDetailModel.Type integerValue] == 2){
        [self addSecondVoteDetailView:voteDetailModel];
    }else if ([voteDetailModel.Type integerValue] == 3){
        [self addVoteDetailView:voteDetailModel];
    }
}
-(void)addVoteDetailView:( VoteDetailModel *)voteDetailM{
    _voteDetailView = [[VoteDetailView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h - 64)];
    __weak typeof (self) weakSelf = self;
    _voteDetailView.voteDetailModel = voteDetailModel;
    _voteDetailView.requestVoteStatus = ^(BOOL isSuccess) {
        if (isSuccess == YES) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    [self.view addSubview:_voteDetailView];
}
-(void)addSecondVoteDetailView:( VoteDetailModel *)voteDetailM{
 
    _voteDetailSecondView = [[VoteDetailSecondView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
    _voteDetailSecondView.voteDetailModel = voteDetailModel;
    [self.view addSubview:_voteDetailSecondView];
    
}
#pragma mark - 网络请求
-(void)requestAnswerListInfo:(void(^)(BOOL isSuccess))finish{
    ActivityViewModel * activityVM = [[ActivityViewModel alloc]init];
    [activityVM setBlockWithReturnBlock:^(id returnValue) {
        voteDetailModel = returnValue;
        finish(YES);
    } WithFaileBlock:^{
        
    }];
    [activityVM fatchVoteDetailInfoID:self.voteID];
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
