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
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource,MoreNavViewDelegate>{
    
    NSArray * imageArr;
    NSArray * titleArr;
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
    
    [self configureView];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;

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
            cell.subTitleLabel.text = @"40";
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
    
    switch (indexPath.row) {
        case 0:{

            
        }
            break;
        case 1:{
     
            
        }
            break;
        case 2:{

        }
            break;
        default:
            break;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc]init];
    self.moreHeaderView = [[NSBundle mainBundle]loadNibNamed:@"MoreHeaderView" owner:self options:nil].lastObject;
    
    self.moreHeaderView.goUserInfoBtnClick = ^(UITapGestureRecognizer *tap) {
        
        
    };
    self.moreHeaderView.qRCodeBtnClick = ^(UIButton *button) {
        
        
    };
    [view addSubview:self.moreHeaderView];
    [self.moreHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    self.moreNavView = [[NSBundle mainBundle]loadNibNamed:@"MoreNavView" owner:self options:nil].lastObject;
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
#pragma mark - MoreNavViewDelegate
-(void)CollectViewCilck{
    
    
}
-(void)DiscloseViewCilck{
    
    
}
-(void)EmailViewCilck{
    
    
    
}
-(void)SignInViewCilck{
    
    
    
}
- (void)presentLogin:(UIViewController *)vc
{
    if ([Utility sharedUtility].loginFlage) {
        
    } else {
        
        LoginViewController *loginView = [LoginViewController new];
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginView];
        [vc presentViewController:nav animated:YES completion:nil];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (BOOL)prefersStatusBarHidden{
    return YES;
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
