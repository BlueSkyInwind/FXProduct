//
//  MySettingViewController.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/10.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MySettingViewController.h"
#import "MySettingTableViewCell.h"
#import "ClearCacheTool.h"
#import "AgreementViewModel.h"
#import "FXWebViewController.h"

@interface MySettingViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray * titleArr;

}

@property (nonatomic,strong)UITableView * tableView;

@end

@implementation MySettingViewController

;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置";
    [self addBackItem];
    titleArr = @[@"仅WIFI状态下加载图片",@"清理缓存",@"关于我们"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureView];
    
    
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MySettingTableViewCell" bundle:nil] forCellReuseIdentifier:@"MySettingTableViewCell"];
    
    UILabel * systemVersions = [[UILabel alloc]init];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    systemVersions.text = [NSString stringWithFormat:@"版本号：%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    systemVersions.textColor = kUIColorFromRGB(0x5e5e5e);
    systemVersions.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:systemVersions];
    [systemVersions mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tableView.mas_bottom).with.offset(-20);
        make.width.equalTo(@120);
        make.height.equalTo(@30);
        make.centerX.equalTo(self.tableView.mas_centerX);
    }];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_IS_IPHONE6P) {
        return 70;
    }else{
        return 60;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return titleArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MySettingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MySettingTableViewCell"];
    if (!cell) {
        cell = [[MySettingTableViewCell alloc]init];
    }
    switch (indexPath.row) {
        case 0:{
            
            cell.titileLabel.text = titleArr[indexPath.row];
            cell.wifiSwitch.hidden = NO;
            cell.rightIconImage.hidden = YES;
        }
            break;
        case 1:{
            cell.titileLabel.text = titleArr[indexPath.row];
        }
            break;
        case 2:{
            cell.titileLabel.text = titleArr[indexPath.row];
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
            if ([ClearCacheTool clearCacheWithFilePath:CachePath]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"清理缓存完毕！"];
            }
        }
            break;
        case 2:{
            [self registerAgreementTap];
        }
            break;
        default:
            break;
    }
}
#pragma mark - 点击事件
-(void)registerAgreementTap{
    
    AgreementViewModel * agreementVM = [[AgreementViewModel alloc]init];
    [agreementVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            FXWebViewController * webVC = [[FXWebViewController alloc]init];
            webVC.title = returnMsg.result[@"Title"];
            webVC.Content = returnMsg.result[@"Information"];
            [self.navigationController pushViewController:webVC animated:YES];
        }
    } WithFaileBlock:^{
        
    }];
    [agreementVM fatchRegisterAgreement:2];
    
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
