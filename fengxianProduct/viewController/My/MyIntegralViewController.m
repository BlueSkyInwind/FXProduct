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

@interface MyIntegralViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (strong,nonatomic)UICollectionView * integalCollectionView;


@end

@implementation MyIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的积分";
    [self addBackItem];
    
    
}

-(void)configureView{
    
    UICollectionViewFlowLayout  * columnCustomLayout = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
    _integalCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:columnCustomLayout];
    _integalCollectionView.backgroundColor = [UIColor whiteColor];
    _integalCollectionView.dataSource = self;
    _integalCollectionView.delegate = self;
    [Tool setCornerWithoutRadius:_integalCollectionView borderColor:[UIColor blackColor]];
    [self.view addSubview:_integalCollectionView];
    [self.integalCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.height.equalTo(self.view.mas_bottom);
    }];
    
    [_integalCollectionView registerNib:[UINib nibWithNibName:@"IntegralGoodsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"IntegralGoodsCollectionViewCell"];
    
    [_integalCollectionView registerNib:[UINib nibWithNibName:@"MyIntegralHeaderCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MyIntegralHeaderCollectionViewCell"];
    
    [_integalCollectionView registerNib:[UINib nibWithNibName:@"IntegralAwardCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"IntegralAwardCollectionViewCell"];
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
                MyIntegralHeaderCollectionViewCell *cell1 = [_integalCollectionView dequeueReusableCellWithReuseIdentifier:@"MyIntegralHeaderCollectionViewCell" forIndexPath:indexPath];
        return cell1;
    }else if (indexPath.section == 1){
                IntegralAwardCollectionViewCell *cell2 = [_integalCollectionView dequeueReusableCellWithReuseIdentifier:@"IntegralAwardCollectionViewCell" forIndexPath:indexPath];
        return cell2;

    }else{
                IntegralGoodsCollectionViewCell *cell3 = [_integalCollectionView dequeueReusableCellWithReuseIdentifier:@"IntegralGoodsCollectionViewCell" forIndexPath:indexPath];
        
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
    


}

#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){80,40};
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
