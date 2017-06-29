//
//  MyIntegralViewController.m
//  fengxianProduct
//
//  Created by admin on 2017/6/16.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MyIntegralViewController.h"
#import "IntegralGoodsCollectionViewCell.h"
#import "MyIntegralHeaderCollectionViewCell.h"
#import "IntegralAwardCollectionViewCell.h"
#import "IntegralViewModel.h"
#import "AgreementViewModel.h"
#import "FXWebViewController.h"
#import "MyIntegralListViewController.h"
#import "GoodsDetailViewController.h"
#import "GoodsExchangeViewController.h"
#import "IntegralExchangeListViewController.h"


@interface MyIntegralViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MyIntegralHeaderCollectionViewCellDelegate>{
    
    NSMutableArray * dataArray;
    
    BOOL didAddSperateVerticalLine;
}


@property (strong,nonatomic)UICollectionView * integalCollectionView;


@end

@implementation MyIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的积分";
    dataArray = [_integralM.rows mutableCopy];
    didAddSperateVerticalLine = NO;
    [self addBackItem];
    [self configureView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}
-(void)configureView{
    
    UICollectionViewFlowLayout  * columnCustomLayout = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象

    _integalCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:columnCustomLayout];
    _integalCollectionView.backgroundColor = [UIColor whiteColor];
    _integalCollectionView.dataSource = self;
    _integalCollectionView.delegate = self;
    [self.view addSubview:_integalCollectionView];
    [self.integalCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_integalCollectionView registerNib:[UINib nibWithNibName:@"IntegralGoodsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"IntegralGoodsCollectionViewCell"];
    [_integalCollectionView registerNib:[UINib nibWithNibName:@"MyIntegralHeaderCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MyIntegralHeaderCollectionViewCell"];
    [_integalCollectionView registerNib:[UINib nibWithNibName:@"IntegralAwardCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"IntegralAwardCollectionViewCell"];
}

-(void)backButtonCilck{
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)integralButtonCilck{
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
    [agreementVM fatchRegisterAgreement:1];
    
}

-(void)integralDetailClick{
    
    MyIntegralListViewController * myIntegralListVC = [[MyIntegralListViewController alloc]init];
    [self.navigationController pushViewController:myIntegralListVC animated:YES];

}
-(void)integralConvertDetailClick{
    

    IntegralExchangeListViewController * goodsExchangeVC = [[IntegralExchangeListViewController alloc]init];
    [self.navigationController pushViewController:goodsExchangeVC animated:YES];
    
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;

    }else if (section == 1){
        return 1;

    }else{
        return dataArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MyIntegralHeaderCollectionViewCell *cell1 = [_integalCollectionView dequeueReusableCellWithReuseIdentifier:@"MyIntegralHeaderCollectionViewCell" forIndexPath:indexPath];
        cell1.delegate = self;
                cell1.integralNumLabel.text = [NSString stringWithFormat:@"%@",self.integralM.Integral];
        return cell1;
    }else if (indexPath.section == 1){
        IntegralAwardCollectionViewCell *cell2 = [_integalCollectionView dequeueReusableCellWithReuseIdentifier:@"IntegralAwardCollectionViewCell" forIndexPath:indexPath];
        return cell2;

    }else{
        IntegralGoodsCollectionViewCell *cell3 = [_integalCollectionView dequeueReusableCellWithReuseIdentifier:@"IntegralGoodsCollectionViewCell" forIndexPath:indexPath];

        CGSize contentSize = self.integalCollectionView.contentSize;
        if(didAddSperateVerticalLine == NO) {
            UIView *verticalLine = [[UIView alloc]initWithFrame:CGRectMake(contentSize.width * 0.5 - 0.5, 290, 1, contentSize.height - 8)];
            verticalLine.backgroundColor = [UIColor lightGrayColor];//colorWithRed:225/225.0f green:227/225.0f blue:233/225.0f alpha:1.0];
            verticalLine.alpha = 0.35;
            [self.integalCollectionView addSubview:verticalLine];
            didAddSperateVerticalLine = YES;
        }
        
        UIView *horizontalLine = [[UIView alloc]initWithFrame:CGRectMake(0, (20 + cell3.frame.size.height) * indexPath.row , contentSize.width, 1)];//每一个cell的framee是 17.00, 10.00, 160.00, 160.00  ,
        NSLog(@"%ld, =>  %.2f, %.2f, %.2f, %.2f, ", indexPath.row, horizontalLine.frame.origin.x, horizontalLine.frame.origin.y, horizontalLine.frame.size.width, horizontalLine.frame.size.height);
        horizontalLine.backgroundColor = [UIColor lightGrayColor];
        horizontalLine.alpha = 0.35;
        [self.integalCollectionView addSubview:horizontalLine];
        
        integralGoodsModel * integralGoods = dataArray[indexPath.row];
        cell3.integralGoodsM = integralGoods;
        return cell3;
    }
    return nil;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        
        integralGoodsModel * integralGoods = dataArray[indexPath.row];
        GoodsDetailViewController * goodDetailVC = [[GoodsDetailViewController alloc]init];
        goodDetailVC.goodsId = [NSString stringWithFormat:@"%@",integralGoods.ID];
        [self.navigationController pushViewController:goodDetailVC animated:YES];
        
    }
}

#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return (CGSize){_k_w,230};
    }else if (indexPath.section == 1){
        return (CGSize){_k_w,60};
    }else{
         
        return (CGSize){_k_w/2 - 20,_k_w/2 - 20};
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    return UIStatusBarAnimationSlide;
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
