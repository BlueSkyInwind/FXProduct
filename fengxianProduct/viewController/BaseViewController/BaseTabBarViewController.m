//
//  BaseTabBarViewController.m
//  fxdProduct
//
//  Created by dd on 15/8/3.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseNavigationViewController.h"
#import "NewsViewController.h"
#import "LivesViewController.h"
#import "ActivityViewController.h"
#import "MyViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "NewsViewModel.h"
@interface BaseTabBarViewController () <UITabBarControllerDelegate>

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (![Utility sharedUtility].columnModel) {
//        [[ShareConfig share]obtainNewsColumnInfo:^(BOOL isSuccess) {
//        }];
    }
    
    [[ShareConfig share]obtainLivesColumnInfo];
    [[ShareConfig share]obtainActicityColumnInfo];

    [self setTabbarCon];
    
    if ([Utility sharedUtility].loginFlage) {
        NewsViewModel * newVM = [[NewsViewModel alloc]init ];
        [newVM uploadPushID:[JPUSHService registrationID]];
    }
    self.delegate = self;
}

- (void)setTabbarCon
{
    
    NSArray *vcNameArr = @[@"NewsViewController",@"LivesViewController",@"ActivityViewController",@"MyViewController"];
    NSArray *titleArr = @[@"新闻",@"生活",@"活动",@"我的"];
    NSArray *imageArr = @[@"news_tabbar_Icon",@"lives_tabbar_Icon",@"activity_tabbar_Icon",@"my_tabbar_Icon"];
    NSArray *seleteimageArr = @[@"news_tabbar_Icon_selected",@"lives_tabbar_Icon_selected",@"activity_tabbar_Icon_selected",@"my_tabbar_Icon_selected"];
    
    NSMutableArray *ncArr = [NSMutableArray array];
    
    for (int i = 0; i < vcNameArr.count; i++) {
        //将字符串转化成类
        Class vc = NSClassFromString([vcNameArr objectAtIndex:i]);
        
        //父类指针指向子类对象
        UIViewController *viewController = [[vc alloc]init];
        BaseNavigationViewController *nc = [[BaseNavigationViewController alloc]initWithRootViewController:viewController];
        viewController.navigationItem.title = [titleArr objectAtIndex:i];
        //        UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:[titleArr objectAtIndex:i] image:nil selectedImage:nil];
        nc.tabBarItem = [self tabBarItemWithName:[titleArr objectAtIndex:i] image:[imageArr objectAtIndex:i] selectedImage:[seleteimageArr objectAtIndex:i]];
        [ncArr addObject:nc];
    }
    self.viewControllers = ncArr;
    
}

//设置tabbar的图标
- (UITabBarItem *)tabBarItemWithName:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName
{
    UIImage *image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:title image:image selectedImage:selectedImage];
    //    [item setImageInsets:UIEdgeInsetsMake(3, 0, -3, 0)];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:rgb(153, 153, 153)} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:UI_MAIN_COLOR} forState:UIControlStateSelected];
    [item setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    return item;
}

-(void)makeTabBarHidden:(BOOL)hide { // Custom code to hide TabBar
    if ( [self.view.subviews count] < 2 ) { return;
    }
    UIView *contentView; if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] ) {
        contentView = [self.view.subviews objectAtIndex:1]; } else {
            contentView = [self.view.subviews objectAtIndex:0]; }
    if (hide) {
        contentView.frame = self.view.bounds; } else {
            contentView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y,
                                           self.view.bounds.size.width, self.view.bounds.size.height -
                                           self.tabBar.frame.size.height); }
    self.tabBar.hidden = hide;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (tabBarController.selectedIndex == 1) {

    }
}

- (void)presentLogin:(UIViewController *)vc
{
    LoginViewController *loginView = [LoginViewController new];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginView];
    [vc presentViewController:nav animated:YES completion:nil];
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
