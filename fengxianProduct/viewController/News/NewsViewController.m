//
//  NewsViewController.m
//  fengxianProduct
//
//  Created by admin on 2017/6/6.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "NewsViewController.h"
#import "TGSementBarVC.h"
#import "HomePageViewController.h"
#import "SubViewController.h"
#import "MyColumnViewController.h"
#import "NewsViewModel.h"
#import "SearchBarViewController.h"
#import "DateAndWeatherView.h"
#import "NoticeView.h"

@interface NewsViewController (){
    
    NSMutableArray * items;
    
}

@property (nonatomic, strong) TGSementBarVC *segmentBarVC;
@property (nonatomic, strong) DateAndWeatherView * dateAndWeatherView;
@property (nonatomic, strong) NoticeView * noticeView;

@end

@implementation NewsViewController

- (TGSementBarVC *)segmentBarVC {
    if (!_segmentBarVC) {
        TGSementBarVC *vc = [[TGSementBarVC alloc] init];
        [self addChildViewController:vc];//成链
        _segmentBarVC = vc;
    }
    return _segmentBarVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.title = @"新闻";
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"news_HomeTitle_Icon"]];
    self.navigationItem.titleView = imageView;
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search_Icon"] style:UIBarButtonItemStylePlain target:self action:@selector(GosearchViewContrller)];
    barBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = barBtn;
    [self configureView];
    [self getNewsWeather];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moreColumnClick) name:@"NewsMoreBtnClick" object:nil];
 
    [self setTabBarBadgeValue];
}
-(void)setTabBarBadgeValue{
    
    UITabBarItem * item=[self.tabBarController.tabBar.items objectAtIndex:0];
    if ( [[Utility sharedUtility].userInfo.ColumnNew intValue] != 0) {
        item.badgeValue= [Utility sharedUtility].userInfo.ColumnNew;
    }
    UITabBarItem * item1=[self.tabBarController.tabBar.items objectAtIndex:1];
    if ( [[Utility sharedUtility].userInfo.ColumnLife intValue] != 0) {
        item1.badgeValue= [Utility sharedUtility].userInfo.ColumnLife;
    }
    UITabBarItem * item2=[self.tabBarController.tabBar.items objectAtIndex:2];
    if ( [[Utility sharedUtility].userInfo.ColumnAct intValue] != 0){
        item2.badgeValue= [Utility sharedUtility].userInfo.ColumnAct;
    }

}
-(void)configureView{
    
    self.dateAndWeatherView = [[NSBundle mainBundle]loadNibNamed:@"DateAndWeatherView" owner:self options:nil].lastObject;
    self.dateAndWeatherView.vc = self;
    [self.view addSubview:self.dateAndWeatherView];
    [self.dateAndWeatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.top.equalTo(self.view.mas_top).with.offset(64);
        make.height.equalTo(@30);
    }];
    
    __weak typeof (self) weakSelf = self;
    [self obtainNoticeInfo:^(BOOL isSuccess, NSString *resultStr) {
        weakSelf.noticeView = [[NSBundle mainBundle]loadNibNamed:@"NoticeView" owner:self options:nil].lastObject;
        weakSelf.noticeView.scrollLabel.text = resultStr;
        weakSelf.noticeView.closeNoticeView = ^(UIButton *button) {
            [weakSelf.noticeView removeFromSuperview];
        };
        [weakSelf.dateAndWeatherView addSubview:self.noticeView];
        [weakSelf.noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.dateAndWeatherView);
        }];
    }];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.segmentBarVC.segmentBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35);
    //设置segmentBarVC大小
    self.segmentBarVC.view.frame = CGRectMake(0, 30, _k_w, _k_h - 30);
    //使用segmentBarVC
    [self.view addSubview:self.segmentBarVC.view];
    [self getDataOfSegmentBarVC:[[Utility sharedUtility].columnModel.rows mutableCopy]];
    [self.view bringSubviewToFront:self.dateAndWeatherView];
    
}
-(void)getDataOfSegmentBarVC:(NSMutableArray *)array{
    
    items = [NSMutableArray array];
    if ([Utility sharedUtility].columnModel) {
        [array enumerateObjectsUsingBlock:^(ColumnInfoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ColumnInfoModel * infoModel = (ColumnInfoModel *)obj;
            NSString * title = infoModel.Title;
            if ([infoModel.According intValue] == 1) {
                [items addObject:title];
            }
        }];
    }
    NSMutableArray* childVCs = [NSMutableArray array];
    [childVCs addObject:[[HomePageViewController alloc] init]];
    if (items.count == 0) {
        return;
    }
    for (int  i = 0; i < items.count - 1; i++) {
        SubViewController * subVc = [[SubViewController alloc] init];
        subVc.columnID = i + 1;
        [childVCs addObject:subVc];
    }
    [self.segmentBarVC setupWithItems:items childVCs:childVCs];
    [self.segmentBarVC.segmentBar updateViewWithConfig:^(TGSegmentConfig *config) {
        config.selectedColor(UI_MAIN_COLOR)
        .normalColor([UIColor blackColor])
        .selectedFont([UIFont systemFontOfSize:14])//选中字体大于其他正常标签的字体的情况下，根据情况稍微调大margin（默认8），以免选中的字体变大后挡住其他正常标签的内容
        .normalFont([UIFont systemFontOfSize:13])
        .indicateExtraW(8)
        .indicateH(2)
        .indicateColor(UI_MAIN_COLOR)
        .showMore(YES)//是否显示更多面板
        .circleScroll(YES)//是否循环滚动，第0个再向前，那么到最后一个;最后一个向后，那么到第0个
        .moreCellBGColor([[UIColor grayColor] colorWithAlphaComponent:0.3])
        .moreBGColor([UIColor clearColor])
        .moreCellFont([UIFont systemFontOfSize:13])
        .moreCellTextColor(UI_MAIN_COLOR)
        .moreCellMinH(30)
        .showMoreBtnlineView(YES)
        .moreBtnlineViewColor([UIColor grayColor])
        .moreBtnTitleFont([UIFont systemFontOfSize:13])
        .moreBtnTitleColor([UIColor blackColor])
        .margin(18)
        .barBGColor([UIColor whiteColor])
        ;
    }];
}


-(void)getNewsWeather{
    NewsViewModel * newsVM = [[NewsViewModel alloc]init];
    [newsVM setBlockWithReturnBlock:^(id returnValue) {
        
    } WithFaileBlock:^{
        
    }];
    [newsVM fatchWeatherInfo];
}

-(void)obtainNoticeInfo:(void(^)(BOOL isSuccess,NSString * resultStr))finish{
    if (![Utility sharedUtility].loginFlage) {
        return;
    }
    
    NewsViewModel * newsVM = [[NewsViewModel alloc]init];
    [newsVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode integerValue] == 1) {
            NSString * str = returnMsg.result[@"Title"];
            finish(YES,str);
        }
    } WithFaileBlock:^{
        
    }];
    [newsVM obatainUserNotice];

}

#pragma mark - 点击事件
-(void)moreColumnClick{
    
    MyColumnViewController * myColumnVC = [[MyColumnViewController alloc]init];
    myColumnVC.columnType = @"1";
    myColumnVC.dataArr =  [[Utility sharedUtility].columnModel.rows mutableCopy];
    __weak typeof (self) weakSelf = self;
    myColumnVC.columnResult = ^(NSMutableArray *resultArr) {
         [weakSelf getDataOfSegmentBarVC:resultArr];
    };
    [self.navigationController pushViewController:myColumnVC animated:YES];
    
}
-(void)GosearchViewContrller{
    //可以加动画
    SearchBarViewController * searchBarVC = [[SearchBarViewController alloc]init];
    [self.navigationController pushViewController:searchBarVC animated:YES];
    
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
