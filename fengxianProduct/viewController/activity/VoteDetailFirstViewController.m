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


@interface VoteDetailFirstViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)UITableView * tableView;
@end

@implementation VoteDetailFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
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
