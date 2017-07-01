//
//  VoteDetailSecondView.m
//  fengxianProduct
//
//  Created by admin on 2017/6/30.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "VoteDetailSecondView.h"
#import "VoteSecondCollectionViewCell.h"
#import "ActivityViewModel.h"
#import <WebKit/WebKit.h>
#import "VoteProgressCollectionViewCell.h"

@interface VoteDetailSecondView ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    
    NSMutableArray * dataArr;
    
    float IntroductionHeight;
    
    NSMutableArray * voteChooseArr;

    
}
@property (nonatomic,strong)UICollectionView * integalCollectionView;

@end
@implementation VoteDetailSecondView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
        voteChooseArr = [NSMutableArray array];

    }
    return self;
}
-(void)setVoteDetailModel:(VoteDetailModel *)voteDetailModel{
    _voteDetailModel = voteDetailModel;
    IntroductionHeight = [Tool heightForText:_voteDetailModel.Introduction width:_k_w font:15] + 15;
    dataArr = [_voteDetailModel.rows mutableCopy];
    [_integalCollectionView reloadData];
}
-(void)configureView{
    
    UICollectionViewFlowLayout  * columnCustomLayout = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
    
    _integalCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _k_w, _k_h - 64) collectionViewLayout:columnCustomLayout];
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

    [_integalCollectionView registerNib:[UINib nibWithNibName:@"VoteProgressCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"VoteProgressCollectionViewCell"];

}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return dataArr.count;
    }else if (section == 3){
        return 1;
    }else{
        return 1;
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
    }else if(indexPath.section == 2){
        VoteRowsModel * voteRowsM = dataArr[indexPath.row];
        VoteSecondCollectionViewCell *cell3 = [_integalCollectionView dequeueReusableCellWithReuseIdentifier:@"VoteSecondCollectionViewCell" forIndexPath:indexPath];
        cell3.voteRowsM = voteRowsM;
        cell3.votechoose = ^(BOOL isSelected) {
            if (isSelected) {
                
                [voteChooseArr addObject:voteRowsM.ID];
            }else{
                [voteChooseArr removeObject:voteRowsM.ID];
            }
        };
        return cell3;
    }else if(indexPath.section == 3){
        VoteProgressCollectionViewCell *cell4 = [_integalCollectionView dequeueReusableCellWithReuseIdentifier:@"VoteProgressCollectionViewCell" forIndexPath:indexPath];
        cell4.voteDetailModel = self.voteDetailModel;
        return cell4;
    }else{
        UICollectionViewCell * cell = [_integalCollectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        UIButton * applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [applyButton setTitle:@"投 票" forState:UIControlStateNormal];
        [applyButton setTintColor:[UIColor whiteColor]];
        [applyButton setBackgroundColor:UI_MAIN_COLOR];
        applyButton.layer.cornerRadius = 8;
        applyButton.layer.masksToBounds = YES;
        [applyButton addTarget:self action:@selector(applyButtonCilck:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:applyButton];
        [applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.mas_centerY);
            make.left.equalTo(cell.mas_left).with.offset(_k_w / 3);
            make.right.equalTo(cell.mas_right).with.offset(_k_w /  (-3));
            make.height.equalTo(@45);
        }];
        return cell;
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
    }else if (indexPath.section == 2){
        return (CGSize){_k_w/2 - 20,_k_w/2 - 20};
    }else if (indexPath.section == 3){
        return (CGSize){_k_w,150};
    }else{
        return (CGSize){_k_w,90};
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

-(void)applyButtonCilck:(id)sender{
    
    ActivityViewModel * activityVM = [[ActivityViewModel alloc]init];
    [activityVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode integerValue] == 1) {
            if (self.requestVoteStatus) {
                self.requestVoteStatus(YES);
            }
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self message:(NSString *)returnMsg.msg];
            if (self.requestVoteStatus) {
                self.requestVoteStatus(NO);
            }
        }
    } WithFaileBlock:^{
        
    }];
    if (voteChooseArr.count == 0) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self message:@"请选择投票！"];
        return;
    }
    NSString * conStr = voteChooseArr.firstObject;
    for (int i = 1; i < voteChooseArr.count; i++) {
        NSString * ID = voteChooseArr[i];
        [conStr stringByAppendingFormat:@",%@",ID];
    }
    
    [activityVM requestAddVote:conStr];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
