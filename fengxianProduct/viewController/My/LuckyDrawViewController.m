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
@interface LuckyDrawViewController (){
    AwardModel * awardModel;
}

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
    __weak typeof (self) weakSelf = self;
    [self obtainDataOfAward:^(BOOL isSuccess) {
        [weakSelf configureView];
    }];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(beginAwardTap)];
    [self.beginAwardView addGestureRecognizer:tap];
    
}
-(void)beginAwardTap{
    
    
    
}
-(void)myAwardList{
    
    
    
}

-(void)configureView{
    
    float borderX = 8;
    float borderY = 8;
    float width = (self.awardBackView.frame.size.width - 32) / 3;
    float height = (self.awardBackView.frame.size.height - 32) / 3;

    
    for (int i = 0; i < 9; i ++) {
        
        AwardGoodsModel * awardGoodsM = awardModel.rows[i];
        float row = i /3;
        float col = i %3;
        
        float originX = borderX +  row *(width + borderX);
        float originY = borderY +  col *(height + borderY);
        AwardView * awardView =  [[NSBundle mainBundle]loadNibNamed:@"AwardView" owner:self options:nil].lastObject;
        [awardView.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:awardGoodsM.Image]];
        awardView.GoodNumberLabel.text = awardGoodsM.Title;
        awardView.backImageView.tag = 1000+i;
        awardView.frame= CGRectMake(originX, originY, width, height);
        [self.awardBackView addSubview:awardView];
    }
}
#pragma mark 设置动画

-(CAAnimation *)animationRotate:(NSInteger) repeatCount

{
    
    CATransform3D rotationTransform =  CATransform3DMakeRotation(M_PI/2,0, 1, 0);
    
    CABasicAnimation *animation;
    
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.toValue = [NSValue valueWithCATransform3D:rotationTransform];
    
    animation.duration = 0.5;
    
    animation.autoreverses = YES;
    
    animation.cumulative = YES;
    
    animation.repeatCount = repeatCount;
    
    animation.delegate = self;
    
    return animation;
    
}
-(void)obtainDataOfAward:(void(^)(BOOL isSuccess))finish{
    
        IntegralViewModel * integralViewM = [[IntegralViewModel alloc]init];
    [integralViewM setBlockWithReturnBlock:^(id returnValue) {
        awardModel = returnValue;
        finish(YES);
    } WithFaileBlock:^{
        
    }];
    [integralViewM requestAwardGoodsInfo];

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
