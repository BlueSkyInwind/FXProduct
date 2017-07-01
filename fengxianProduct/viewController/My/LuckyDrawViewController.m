//
//  LuckyDrawViewController.m
//  fengxianProduct
//
//  Created by admin on 2017/6/29.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "LuckyDrawViewController.h"

@interface LuckyDrawViewController ()

@end

@implementation LuckyDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"积分抽奖";
    [self addBackItem];
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithTitle:@"我的奖品" style:UIBarButtonItemStylePlain target:self action:@selector(myAwardList)];
    barBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = barBtn;
}
-(void)myAwardList{
    
    
    
    
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
