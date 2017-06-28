//
//  GoodsDetailViewController.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/27.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GoodDetailHeaderView.h"
#import "GoodsContentView.h"
#import "MoreViewModel.h"
#import "GoodsDetailModel.h"
@interface GoodsDetailViewController (){
    GoodsDetailModel * goodDetailModel;
}


@property (nonatomic,strong)UIScrollView * backScrollView;
@property (nonatomic,strong)GoodDetailHeaderView * goodDetailHeaderView;
@property (nonatomic,strong)GoodsContentView * goodsContentView;

@property (nonatomic,strong)UIButton * exchangeBtn;
@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"商品详情";
    [self addBackItem];
    
    __weak typeof (self) weakSelf = self;
    [self fatchGoodsDetail:^(BOOL isSuccess) {
        [weakSelf configureview];
    }];
    
}
-(void)configureview{
    
    
    self.backScrollView = [[UIScrollView alloc]init];
    self.backScrollView.backgroundColor = kUIColorFromRGB(0xe5e5e5);
//    self.backScrollView.contentSize = CGSizeMake(_k_w, _k_h);
    [self.view addSubview:self.backScrollView];
    [self.backScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.goodDetailHeaderView = [[NSBundle mainBundle]loadNibNamed:@"GoodDetailHeaderView" owner:self options:nil].lastObject;
    [self.goodDetailHeaderView.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:goodDetailModel.Images.firstObject[@"Image"]] placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_1" ] options:SDWebImageRefreshCached];
    
    self.goodDetailHeaderView.GoodsTitle.text = goodDetailModel.Title;
    self.goodDetailHeaderView.GoodsIntegral.text = goodDetailModel.Integral;
    self.goodDetailHeaderView.GoodsNum.text = goodDetailModel.Num;
    
    NSInteger height = 240;
    if (UI_IS_IPHONE6) {
        height = 260;
    }else if (UI_IS_IPHONE6P){
        height = 300;
    }
    [self.backScrollView addSubview:self.goodDetailHeaderView];
    [self.goodDetailHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backScrollView.mas_top).with.offset(0);
        make.left.equalTo(self.backScrollView.mas_left);
        make.right.equalTo(self.backScrollView.mas_right);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@(height));
    }];
    
    float contentHeight = [Tool heightForText:goodDetailModel.Information width:_k_w - 30 font:14] + 45;

    self.goodsContentView = [[NSBundle mainBundle]loadNibNamed:@"GoodsContentView" owner:self options:nil].lastObject;
    self.goodsContentView.contentTitle.text = @"商品详情";
    self.goodsContentView.GoodContent.text = goodDetailModel.Information;
    
    [self.backScrollView addSubview:self.goodsContentView];
    [self.goodsContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodDetailHeaderView.mas_bottom).with.offset(20);
        make.left.equalTo(self.backScrollView.mas_left);
        make.right.equalTo(self.backScrollView.mas_right);
        make.width.equalTo(self.view.mas_width);

        make.height.equalTo(@(contentHeight));
    }];
    
    
    self.exchangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.exchangeBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
    [self.exchangeBtn setBackgroundColor:UI_MAIN_COLOR];
    [self.exchangeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.exchangeBtn addTarget:self action:@selector(exchangeGoodClick) forControlEvents:UIControlEventTouchUpInside];
    self.exchangeBtn.layer.cornerRadius = 5;
    self.exchangeBtn.clipsToBounds = YES;
    [self.backScrollView addSubview:self.exchangeBtn];
    [self.exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsContentView.mas_bottom).with.offset(30);
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.height.equalTo(@(40));
        make.width.equalTo(@(140));
    }];
}
-(void)exchangeGoodClick{
    
    
    
    
}

-(void)fatchGoodsDetail:(void(^)(BOOL isSuccess))finish{
    
    MoreViewModel * moreVM = [[MoreViewModel alloc]init];
    [moreVM setBlockWithReturnBlock:^(id returnValue) {
        goodDetailModel = returnValue;
        finish(YES);
        
    } WithFaileBlock:^{
        
    }];
    [moreVM fatchGoodsDetailInfo:self.goodsId];

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
