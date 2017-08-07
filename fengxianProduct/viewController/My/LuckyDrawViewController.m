//
//  LuckyDrawViewController.m
//  fengxianProduct
//
//  Created by admin on 2017/6/29.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "LuckyDrawViewController.h"
#import "AwardView.h"
#import "AwardModel.h"
#import "IntegralViewModel.h"
#import "AwardResultModel.h"
#import "AwardResultReminderView.h"
#import "MyAwardListViewController.h"

@interface LuckyDrawViewController (){
    AwardModel * awardModel;
    AwardView * currentAwardView;
    
    NSTimer * awardTimer;
    NSInteger currentIndex;
    
    AwardResultModel * awardResultModel;
    
    UIView * maskView;
}
@property (nonatomic,strong)AwardResultReminderView * awardResultReminderView;
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
    if (UI_IS_IPHONE5 || UI_IS_IPHONE4) {
        self.awardBackViewTop.constant = 60;
    }
    __weak typeof (self) weakSelf = self;
    [self obtainDataOfAward:^(BOOL isSuccess) {
        [weakSelf configureView];
    }];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(beginAwardTap)];
    [self.beginAwardView addGestureRecognizer:tap];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [awardTimer invalidate];
    awardTimer = nil;
}

-(void)beginAwardTap{
    
    [self awardAnimation];
    
}
-(void)myAwardList{
    MyAwardListViewController  * myAwardListVC = [[MyAwardListViewController alloc]init];
    [self.navigationController pushViewController:myAwardListVC animated:YES];
}

-(void)configureView{
    
    float borderX = 8;
    float borderY = 8;
    float width = (self.awardBackView.frame.size.width - 32) / 3;
    float height = (self.awardBackView.frame.size.height - 32) / 3;

    
    for (int i = 0; i < awardModel.rows.count; i ++) {
        
        AwardGoodsModel * awardGoodsM = awardModel.rows[i];
        float col = i / 3;
        float row = i % 3;
        
        float originX = borderX +  row *(width + borderX);
        float originY = borderY +  col *(height + borderY);
        AwardView * awardView =  [[NSBundle mainBundle]loadNibNamed:@"AwardView" owner:self options:nil].lastObject;
        [awardView.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:awardGoodsM.Image]];
        awardView.GoodNumberLabel.text = awardGoodsM.Title;
        awardView.tag = 1000+i;
        awardView.frame= CGRectMake(originX, originY, width, height);
        [self.awardBackView addSubview:awardView];
    }
}

#pragma mark 设置动画

-(void)initAwardViewStatus{
    for (UIView * view in self.awardBackView.subviews) {
        if (view.tag >= 1000) {
            AwardView * awardView = (AwardView *)view;
            awardView.backImageView.image = [UIImage imageNamed:@"integral_award_red_Icon"];
        }
    }
}

-(void)awardAnimation
{
    awardTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    currentIndex = 1000;
    [self performSelector:@selector(beginAward) withObject:self afterDelay:2];
}
-(void)changeImage{
    
    [self initAwardViewStatus];
    for (UIView * view in self.awardBackView.subviews) {
        if (view.tag >= 1000 && view.tag == currentIndex) {
//            NSLog(@"%@",view);
            currentAwardView = (AwardView *)view;
            currentAwardView.backImageView.image = [UIImage imageNamed:@"integral_award_animation_Icon"];
        }
    }
    currentIndex += 1;
    if (currentIndex > 1008) {
        currentIndex = 1000;
    }
}
#pragma mark - 网络请求
-(void)obtainDataOfAward:(void(^)(BOOL isSuccess))finish{
    
    IntegralViewModel * integralViewM = [[IntegralViewModel alloc]init];
    [integralViewM setBlockWithReturnBlock:^(id returnValue) {
        awardModel = returnValue;
        finish(YES);
    } WithFaileBlock:^{
        
    }];
    [integralViewM requestAwardGoodsInfo];
}

-(void)beginAward{
    
    IntegralViewModel * integralViewM = [[IntegralViewModel alloc]init];
    [integralViewM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        //销毁定时器
        [awardTimer invalidate];
        awardTimer = nil;
        [self initAwardViewStatus];
        if ([returnMsg.returnCode intValue] == 1) {
            awardResultModel = [[AwardResultModel alloc]initWithDictionary:(NSDictionary *)returnMsg.result error:nil];
            [self showAwardResultViewTitleLabel:awardResultModel.Title isSuccess:YES contentStr:awardResultModel.Address];

        }else{
            [self showAwardResultViewTitleLabel:(NSString *)returnMsg.msg isSuccess:NO contentStr:@"听说多抽几次可以提高抽中率哦！"];
        }
    } WithFaileBlock:^{
        //销毁定时器
        [awardTimer invalidate];
        awardTimer = nil;
        [self initAwardViewStatus];
    }];
    [integralViewM requestAwardGoodsResult];
}

#pragma mark -
-(void)showAwardResultViewTitleLabel:(NSString *)title isSuccess:(BOOL)isSuccess contentStr:(NSString *)contentStr{
    
    maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.7;
    [self.view addSubview:maskView];
    
    _awardResultReminderView =  [[NSBundle mainBundle]loadNibNamed:@"AwardResultReminderView" owner:self options:nil].lastObject;
    _awardResultReminderView.frame = CGRectMake(0, 0, _k_w - 20, 181);
    _awardResultReminderView.center = maskView.center;
    _awardResultReminderView.titleLabel.text = title;
    _awardResultReminderView.contentLabel.text = contentStr;
    if (isSuccess) {
        _awardResultReminderView.conentImageView.image = [UIImage imageNamed:@"integral_award_smile_Icon"];
    }else{
       _awardResultReminderView.conentImageView.image = [UIImage imageNamed:@"integral_award_cry_Icon"]; 
    }
    _awardResultReminderView.layer.cornerRadius = 5;
    _awardResultReminderView.clipsToBounds = YES;
    __weak typeof (self) weakSelf = self;
    _awardResultReminderView.closeAwardResultView = ^(UIButton *button) {
        [weakSelf removeAwardResultReminderView];
    };
    [self.view addSubview:_awardResultReminderView];
}

-(void)removeAwardResultReminderView{
    [maskView removeFromSuperview];
    [_awardResultReminderView removeFromSuperview];
    maskView = nil;
    _awardResultReminderView = nil;
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
