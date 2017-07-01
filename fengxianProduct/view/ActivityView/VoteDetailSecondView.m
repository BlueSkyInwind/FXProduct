//
//  VoteDetailSecondView.m
//  fengxianProduct
//
//  Created by admin on 2017/6/30.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "VoteDetailSecondView.h"
#import "VoteSecondCollectionViewCell.h"

@interface VoteDetailSecondView ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    
    NSMutableArray * dataArr;
    
    float IntroductionHeight;
    
}
@property (nonatomic,strong)UICollectionView * integalCollectionView;

@end
@implementation VoteDetailSecondView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}
-(void)setVoteDetailModel:(VoteDetailModel *)voteDetailModel{
    _voteDetailModel = voteDetailModel;
    IntroductionHeight = [Tool heightForText:_voteDetailModel.Introduction width:_k_w font:15] + 15;
    dataArr = [_voteDetailModel.rows mutableCopy];
    [self configureView];
}
-(void)configureView{
    
    UICollectionViewFlowLayout  * columnCustomLayout = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
    
    _integalCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:columnCustomLayout];
    _integalCollectionView.backgroundColor = [UIColor whiteColor];
    _integalCollectionView.dataSource = self;
    _integalCollectionView.delegate = self;
    [self addSubview:_integalCollectionView];
    [self.integalCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_integalCollectionView registerNib:[UINib nibWithNibName:@"VoteSecondCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"VoteSecondCollectionViewCell"];
    [_integalCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_integalCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell1"];

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
        return dataArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        UICollectionViewCell * cell = [_integalCollectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 200)];
        [imageView  sd_setImageWithURL:[NSURL URLWithString:_voteDetailModel.Image] placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_1" ]options:SDWebImageRefreshCached];
        [cell.contentView addSubview:imageView];
        return cell;
    }else if (indexPath.section == 1){
        UICollectionViewCell * cell1 = [_integalCollectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, _k_w, IntroductionHeight)];
        webView.userInteractionEnabled = NO;
        [webView loadHTMLString:_voteDetailModel.Introduction baseURL:nil];
        [cell1.contentView addSubview:webView];
        return cell1;
    }else{
        VoteRowsModel * voteRowsM = dataArr[indexPath.row];
        VoteSecondCollectionViewCell *cell3 = [_integalCollectionView dequeueReusableCellWithReuseIdentifier:@"VoteSecondCollectionViewCell" forIndexPath:indexPath];
        cell3.voteRowsM = voteRowsM;
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
    if (indexPath.section == 0) {
        return (CGSize){_k_w,_k_w * 4 / 7};
    }else if (indexPath.section == 1){
        return (CGSize){_k_w,IntroductionHeight};
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



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
