//
//  MyMessageViewController.m
//  fengxianProduct
//
//  Created by admin on 2017/6/22.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MyMessageViewController.h"
#import "SystemMessageViewController.h"
#import "CommentMessageViewController.h"

@interface MyMessageViewController (){
    
    BOOL isEdit;

}
@property (nonatomic,strong)SystemMessageViewController * systemMessageVC;
@property (nonatomic,strong)CommentMessageViewController * commentMessageVC;

@end

@implementation MyMessageViewController


- (SystemMessageViewController *)systemMessageVC {
    if (!_systemMessageVC) {
        SystemMessageViewController *vc = [[SystemMessageViewController alloc] init];
        [self addChildViewController:vc];//成链
        _systemMessageVC = vc;
    }
    return _systemMessageVC;
}
- (CommentMessageViewController *)commentMessageVC {
    if (!_commentMessageVC) {
        CommentMessageViewController *vc = [[CommentMessageViewController alloc] init];
        [self addChildViewController:vc];//成链
        _commentMessageVC = vc;
    }
    return _commentMessageVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的消息";
    [self addBackItem];
    isEdit = NO;
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editCollectList)];
    barBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = barBtn;

    [self configureView];
}
-(void)editCollectList{
    
    isEdit = !isEdit;
    if (self.systemMessageVC.view.hidden == NO) {
        self.systemMessageVC.isEdit = isEdit;
        [self.systemMessageVC.tableView reloadData];
    }
    
    if (self.commentMessageVC.view.hidden == NO) {
        self.commentMessageVC.isEdit = isEdit;
        [self.commentMessageVC.tableView reloadData];
    }
    if (isEdit) {
        self.navigationItem.rightBarButtonItem.title = @"完成";
        [self.systemMessageVC showBottomDeleteView];
        [self.commentMessageVC showBottomDeleteView];

    }else{
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        [self.systemMessageVC removeBottomDeleteView];
        [self.commentMessageVC removeBottomDeleteView];

    }
}

- (IBAction)systemBtnClick:(id)sender {
    
    if (self.systemMessageVC.view.hidden == YES) {
        isEdit = NO;
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        [self.commentMessageVC removeBottomDeleteView];
    }

    self.sysTemView.hidden = NO;
    self.commentView.hidden = YES;
    
    self.commentMessageVC.view.hidden = YES;
    self.systemMessageVC.view.hidden = NO;

}
- (IBAction)commentBtnClick:(id)sender {
    
    
    if (self.commentMessageVC.view.hidden == YES) {
        isEdit = NO;
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        [self.systemMessageVC removeBottomDeleteView];
    }
    isEdit = NO;
    self.sysTemView.hidden = YES;
    self.commentView.hidden = NO;
    
    self.commentMessageVC.view.hidden = NO;
    self.systemMessageVC.view.hidden = YES;
    
}

-(void)configureView{
    
    self.sysTemView.hidden = NO;
    self.commentView.hidden = YES;
    
    self.systemMessageVC.view.frame = CGRectMake(0, 114, _k_w, _k_h - 104);
    self.commentMessageVC.view.frame = CGRectMake(0, 114, _k_w, _k_h - 104);
    [self.view addSubview:_commentMessageVC.view];
    [self.view addSubview:_systemMessageVC.view];
    self.commentMessageVC.view.hidden = YES;
    self.systemMessageVC.view.hidden = NO;
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
