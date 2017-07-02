//
//  MyViewController.m
//  fengxianProduct
//
//  Created by admin on 2017/6/6.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MyViewController.h"
#import "MoreNavView.h"
#import "MoreHeaderView.h"
#import "MoreTableViewCell.h"
#import "MoreViewModel.h"
#import "LoginViewController.h"
#import "UserInfoViewController.h"
#import "InvationRegisterView.h"
#import "MySettingViewController.h"
#import "FeedbackViewController.h"
#import "MyIntegralViewController.h"
#import "IntegralViewModel.h"
#import "integralModel.h"
#import "MyCollectViewController.h"
#import "MyBrokeViewController.h"
#import "MyMessageViewController.h"
#import "SignAndCollectMdoel.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource,MoreNavViewDelegate>{
    
    NSArray * imageArr;
    NSArray * titleArr;
    
    NSMutableArray * dataArray;
    integralModel * accountIntegralM;
    
}

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)MoreTableViewCell * moreTableViewCell;
@property (nonatomic,strong)MoreNavView * moreNavView;
@property (nonatomic,strong)MoreHeaderView * moreHeaderView;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    imageArr = @[@"More_jifenduihuan",@"More_feedBack",@"More_setting"];
    titleArr = @[@"积分兑换",@"我的反馈",@"我的设置"];
    dataArray = [NSMutableArray array];
    [self configureView];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];
    if ([Utility sharedUtility].loginFlage) {
        [self obtainIntegral:^(integralModel *integralModel) {
        }];
        [self obtainSignStatus];
    }
    
    [self.moreHeaderView configureViewImage:[Utility sharedUtility].userInfo.Images AccountID:[Utility sharedUtility].userInfo.Code userNickName:[Utility sharedUtility].userInfo.Name];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];

}
#pragma mark - 积分请求
-(void)obtainIntegral:(void(^)(integralModel * integralModel))finish
{
    IntegralViewModel * integralM = [[IntegralViewModel alloc]init];
    [integralM setBlockWithReturnBlock:^(id returnValue) {
        accountIntegralM = [[integralModel alloc]init];
        accountIntegralM = returnValue;
        dataArray = [accountIntegralM.rows mutableCopy];
        finish(accountIntegralM);
        NSIndexPath * indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } WithFaileBlock:^{
        
    }];
    [integralM fatchAccountIntegral];
}

-(void)configureView{
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"MoreTableViewCell"];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_IS_IPHONE6P) {
        return 70;
    }else{
        return 60;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return imageArr.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoreTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MoreTableViewCell"];
    if (!cell) {
        cell = [[MoreTableViewCell alloc]init];
    }
    switch (indexPath.row) {
        case 0:{
            cell.moreCellIcon.image = [UIImage imageNamed:imageArr[indexPath.row]];
            cell.titleIabel.text = titleArr[indexPath.row];
            cell.subTitleLabel.hidden = NO;
            if (accountIntegralM.Integral) {
                cell.subTitleLabel.text = [NSString stringWithFormat:@"%@",accountIntegralM.Integral];
            }
        }
            break;
        case 1:{
            cell.moreCellIcon.image = [UIImage imageNamed:imageArr[indexPath.row]];
            cell.titleIabel.text = titleArr[indexPath.row];
        }
            break;
        case 2:{
            cell.moreCellIcon.image = [UIImage imageNamed:imageArr[indexPath.row]];
            cell.titleIabel.text = titleArr[indexPath.row];
        }
            break;
        default:
            break;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![[ShareConfig share] isPresentLoginVC:self]) {
        return;
    }

    switch (indexPath.row) {
        case 0:{
            if (accountIntegralM) {
                MyIntegralViewController * myIntegralVC  = [[MyIntegralViewController alloc]init];
                myIntegralVC.integralM = accountIntegralM;
                [self.navigationController pushViewController:myIntegralVC animated:YES];
            }
        }
            break;
        case 1:{

            FeedbackViewController * feedbackVC  = [[FeedbackViewController alloc]init];
            [self.navigationController pushViewController:feedbackVC animated:YES];
        }
            break;
        case 2:{
            MySettingViewController * mySettingVC  = [[MySettingViewController alloc]init];
            [self.navigationController pushViewController:mySettingVC animated:YES];
        }
            break;
        default:
            break;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc]init];
    self.moreHeaderView = [[NSBundle mainBundle]loadNibNamed:@"MoreHeaderView" owner:self options:nil].lastObject;
    [self.moreHeaderView configureViewImage:[Utility sharedUtility].userInfo.Images AccountID:[Utility sharedUtility].userInfo.Code userNickName:[Utility sharedUtility].userInfo.Name];
    __weak typeof (self) weakSelf = self;
    self.moreHeaderView.goUserInfoBtnClick = ^(UITapGestureRecognizer *tap) {
        if ([[ShareConfig share] isPresentLoginVC:weakSelf]) {
            UserInfoViewController * userInfoVC = [[UserInfoViewController alloc]init];
            [weakSelf.navigationController pushViewController:userInfoVC animated:YES];
         }
    };
    self.moreHeaderView.qRCodeBtnClick = ^(UIButton *button) {
        if ([[ShareConfig share] isPresentLoginVC:weakSelf]) {
            [weakSelf popInavationView];
        }
    };
    [view addSubview:self.moreHeaderView];
    [self.moreHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    self.moreNavView = [[NSBundle mainBundle]loadNibNamed:@"MoreNavView" owner:self options:nil].lastObject;
    self.moreNavView.vc = self;
    self.moreNavView.delegate = self;
    [view addSubview:self.moreNavView];
    [self.moreNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view).with.offset(0);
        make.right.equalTo(view).with.offset(0);
        make.left.equalTo(view).with.offset(0);
        make.height.equalTo(@50);
    }];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 200;
}

-(void)popInavationView{
    
    [InvationRegisterView showInvationView:self];

}

#pragma mark - MoreNavViewDelegate
-(void)CollectViewCilck{
    if ([[ShareConfig share] isPresentLoginVC:self]) {
        MyCollectViewController * myCollectViewController = [[MyCollectViewController  alloc]init];
        [self.navigationController pushViewController:myCollectViewController animated:YES];
    }
}
-(void)DiscloseViewCilck{
    
    if ([[ShareConfig share] isPresentLoginVC:self]) {
        MyBrokeViewController * myBrokeVC = [[MyBrokeViewController  alloc]init];
        [self.navigationController pushViewController:myBrokeVC animated:YES];
    }
}
-(void)EmailViewCilck{
    
    if ([[ShareConfig share] isPresentLoginVC:self]) {
        MyMessageViewController * myMessageVC = [[MyMessageViewController  alloc]init];
        [self.navigationController pushViewController:myMessageVC animated:YES];
    }
}
-(void)SignInViewCilck{
    
    

}
-(void)obtainSignStatus{
    
    MoreViewModel * moreVM = [[MoreViewModel alloc]init];
    [moreVM setBlockWithReturnBlock:^(id returnValue) {
            SignAndCollectMdoel * signModel  = returnValue;
        if ([signModel.Send integerValue] == 0) {
            if ([signModel.Send intValue] == 0) {
                return;
            }
            self.moreNavView.emailBadgeNum.hidden = NO;
            self.moreNavView.emailBadgeNum.text = [NSString stringWithFormat:@"%@",signModel.Send];
        }
        [self.tableView reloadData];
    } WithFaileBlock:^{
        
    }];
    [moreVM fatchIsSignAndCollect];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    return UIStatusBarAnimationSlide;
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
