//
//  AnswerDetailViewController.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/7/1.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "AnswerDetailViewController.h"
#import "ActivityViewModel.h"
#import "AnswerDetailModel.h"
#import "AnswerDetailView.h"
@interface AnswerDetailViewController (){
    AnswerDetailModel * answerDetailM;
}
@property (nonatomic,strong)AnswerDetailView * answerDetailView;
@end

@implementation AnswerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.answerTitle;
    [self addBackItem];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    __weak typeof (self) weakSelf = self;
    [self requestAnswerListInfo:^(BOOL isSuccess) {
        [weakSelf configureView];
    }];
}
-(void)configureView{
    
    [self addVoteDetailView:answerDetailM];
    
}
-(void)addVoteDetailView:( AnswerDetailModel *)answerDetailModel{
    _answerDetailView = [[AnswerDetailView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h - 64)];
    __weak typeof (self) weakSelf = self;
    _answerDetailView.answerDetailModel = answerDetailModel;
    _answerDetailView.answerID  = self.answerID;
    _answerDetailView.requestAnswerStatus = ^(BOOL isSuccess) {
        if (isSuccess == YES) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    [self.view addSubview:_answerDetailView];
}
#pragma mark - 网络请求
-(void)requestAnswerListInfo:(void(^)(BOOL isSuccess))finish{
    ActivityViewModel * activityVM = [[ActivityViewModel alloc]init];
    [activityVM setBlockWithReturnBlock:^(id returnValue) {
        answerDetailM = returnValue;
        finish(YES);
    } WithFaileBlock:^{
        
    }];
    [activityVM fatchAnswerDEtailInfoID:self.answerID];
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
