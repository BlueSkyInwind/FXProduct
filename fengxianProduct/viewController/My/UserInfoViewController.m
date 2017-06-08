//
//  UserInfoViewController.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/8.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoTableViewCell.h"
@interface UserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSArray * titleArr;
    
    NSMutableArray * contentArr;
}

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UserInfoTableViewCell * userInfoTableViewCell;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.title = @"个人信息";
    [self addBackItem];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveUserInfo)];
    barBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = barBtn;
    
    titleArr = @[@[@"头像",@"账号",@"昵称",@"ID",@"我的二维码名片"],@[@"手机",@"邮箱"],@[@"性别",@"出生日期",@"地址"]];
    
    
    
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

    [self.tableView registerNib:[UINib nibWithNibName:@"UserInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"UserInfoTableViewCell"];
    
}
#pragma  mrak - 点击事件
-(void)saveUserInfo{
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_IS_IPHONE6P) {
        return 70;
    }else{
        return 60;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [titleArr[section] count];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoTableViewCell"];
    if (!cell) {
        cell = [[UserInfoTableViewCell alloc]init];
    }
    cell.titleLabel.text = titleArr[indexPath.section][indexPath.row];
    
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
//                    cell.contentImageView sd_setImageWithURL:[] placeholderImage:<#(nullable UIImage *)#> options:<#(SDWebImageOptions)#>
                }
                    break;
                case 1:{
                    
                    
                }
                    break;
                case 2:{
                    
                    
                }
                    break;
                case 3:{
                    
                    
                }
                    break;

                case 4:{
                    
                    
                }
                    break;

                default:
                    break;

        }
            break;
        case 1:{
            switch (indexPath.row) {
                case 0:
                    
                    break;
                case 1:
                    
                    break;

                    
                default:
                    break;
            }
            
        }
            break;
        case 2:{
            switch (indexPath.row) {
                case 0:
                    
                    break;
                case 1:
                    
                    break;
                case 2:
                    
                    break;
                    
                default:
                    break;
            }

        }
            break;
            
        default:
            break;
    }
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
