//
//  MyColumnViewController.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/11.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MyColumnViewController.h"
#import "CollectionViewCell.h"
#import "ColumnHeaderCollectionReusableView.h"
#import "ColumnViewModel.h"
#import "ColumnCollectionHeader.h"
#import "ColumnModel.h"

@interface MyColumnViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ColumnCollectionHeaderDelegate,UICollectionViewDelegateFlowLayout>{
    
    NSInteger sectionNum;
    NSMutableArray * columnArr;
    NSMutableArray * notAddArr;
    
    BOOL isSave;
}
@property (strong,nonatomic)ColumnCollectionHeader * columnCollectionHeader;
@property (strong,nonatomic)ColumnCollectionHeader * notAddCollectionHeader;

@property (strong,nonatomic)UICollectionView * columnCollectionView;
@property (strong,nonatomic)UICollectionView * notAddcollectionView;

@end

@implementation MyColumnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的栏目";
    [self addBackItem];

    sectionNum = 1;
    isSave = NO;
    columnArr = [NSMutableArray array];
    notAddArr = [NSMutableArray array];
    [self getColumnData];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureView];
}

-(void)getColumnData{
    
    [self.dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ColumnInfoModel * columnInfoM = obj;
        if ([columnInfoM.According intValue] == 1) {
            [columnArr addObject:columnInfoM];
        }else{
            [notAddArr addObject:columnInfoM];
        }
    }];
}

-(void)configureView{
    
    
    self.columnCollectionHeader = [[NSBundle mainBundle]loadNibNamed:@"ColumnCollectionHeader" owner:self options:nil].lastObject;
    self.columnCollectionHeader.delegate = self;
    self.columnCollectionHeader.titleLabel.text = @"我的栏目";
    [self.view addSubview:self.columnCollectionHeader];
    [self.columnCollectionHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.top.equalTo(self.view.mas_top).with.offset(64);
        make.height.equalTo(@35);
    }];
    
    UICollectionViewFlowLayout  * columnCustomLayout = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
    _columnCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:columnCustomLayout];
    _columnCollectionView.backgroundColor = [UIColor whiteColor];
    _columnCollectionView.dataSource = self;
    _columnCollectionView.delegate = self;
    [Tool setCornerWithoutRadius:_columnCollectionView borderColor:[UIColor blackColor]];
    [self.view addSubview:_columnCollectionView];
    [self.columnCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(5);
        make.right.equalTo(self.view.mas_right).with.offset(-5);
        make.top.equalTo(self.columnCollectionHeader.mas_bottom).with.offset(0);
        make.height.equalTo(@120);
    }];
    
    self.notAddCollectionHeader = [[NSBundle mainBundle]loadNibNamed:@"ColumnCollectionHeader" owner:self options:nil].lastObject;
    self.notAddCollectionHeader.titleLabel.text = @"点击添加更多栏目";
    self.notAddCollectionHeader.statusBtn.hidden = YES;
    self.notAddCollectionHeader.closeEditBtn.hidden = YES;
    [self.view addSubview:self.notAddCollectionHeader];
    [self.notAddCollectionHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.top.equalTo(self.columnCollectionView.mas_bottom).with.offset(10);
        make.height.equalTo(@35);
    }];
    
    UICollectionViewFlowLayout  * notAddCustomLayout = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
    _notAddcollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:notAddCustomLayout];
    _notAddcollectionView.backgroundColor = [UIColor whiteColor];
    _notAddcollectionView.dataSource = self;
    _notAddcollectionView.delegate = self;
    [Tool setCornerWithoutRadius:_notAddcollectionView borderColor:[UIColor blackColor]];
    [self.view addSubview:_notAddcollectionView];
    [self.notAddcollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(5);
        make.right.equalTo(self.view.mas_right).with.offset(-5);
        make.top.equalTo(self.notAddCollectionHeader.mas_bottom).with.offset(0);
        make.height.equalTo(@120);
    }];
    
    [self hideNotAddView];
    
     [_columnCollectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];

    [_notAddcollectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
}

-(void)hideNotAddView{
    self.notAddCollectionHeader.hidden = YES;
    self.notAddcollectionView.hidden = YES;
}
#pragma mark - 数据请求
-(void)uploadUserColumnData:(NSMutableArray *)array{
    
    ColumnViewModel * columnVM = [[ColumnViewModel alloc]init];
    [columnVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1){
            if ([_columnType intValue] == 1) {
                [Utility sharedUtility].columnModel.rows = [columnArr mutableCopy];
                [[ShareConfig share]obtainNewsColumnInfo];
            }else if ([_columnType intValue] == 2){
                [Utility sharedUtility].livesColumnModel.rows = [columnArr mutableCopy];
                [[ShareConfig share]obtainLivesColumnInfo];
            }
            if (self.columnResult) {
                self.columnResult(columnArr);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    } WithFaileBlock:^{
        
    }];
    NSString * str = @"column";
    for (ColumnInfoModel * infoModel  in array) {
        
       str = [str stringByAppendingString:[NSString stringWithFormat:@"%@,",infoModel.ColumnID]];
    }
    str = [str stringByReplacingOccurrencesOfString:@"column" withString:@""];
    if ([str isEqualToString:@""]) {
        return;
    }
    [columnVM uploadColumnListType:self.columnType Column:[str substringToIndex:str.length - 1]];
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView  == _columnCollectionView) {
        return columnArr.count;
    }else{
        return notAddArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (collectionView  == _columnCollectionView) {
            CollectionViewCell *cell1 = [_columnCollectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
        if (!isSave || ([self.columnType integerValue] == 1 && indexPath.row < 4)) {
            cell1.deleteImage.hidden = YES;
        }else{
            cell1.deleteImage.hidden = NO;
        }
        ColumnInfoModel * infoModel = columnArr[indexPath.row];
        cell1.titleLabel.text = infoModel.Title;
        return cell1;
        
    }else{
        
        CollectionViewCell *cell2 = [_notAddcollectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
        ColumnInfoModel * infoModel = notAddArr[indexPath.row];
        cell2.titleLabel.text = infoModel.Title;
        return cell2;
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

    if (!isSave) {
        return;
    }
    if (collectionView  == _columnCollectionView) {
        if ([self.columnType integerValue] == 1 && indexPath.row < 4) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"固定栏目不能删除"];
            return;
        }
        ColumnInfoModel * infoModel = columnArr[indexPath.row];
        [columnArr removeObjectAtIndex:indexPath.row];
        infoModel.According = @(0);
        [notAddArr addObject:infoModel];
    }else{
        ColumnInfoModel * infoModel = notAddArr[indexPath.row];
        [notAddArr removeObjectAtIndex:indexPath.row];
        infoModel.According = @(1);
        [columnArr addObject:infoModel];
    }
    [self.columnCollectionView reloadData];
    [self.notAddcollectionView reloadData];
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

#pragma mark - ColumnHeaderCollectionReusableViewDelegate
-(void)saveEditStatus{
    isSave = NO;
    sectionNum = 1;
    [self uploadUserColumnData:columnArr];
    [self.columnCollectionView reloadData];
    [self hideNotAddView];

}
-(void)startEditStatus{
    isSave = YES;
    sectionNum = 2;
    [self.columnCollectionView reloadData];
    [self.notAddcollectionView reloadData];

    self.notAddCollectionHeader.hidden = NO;
    self.notAddcollectionView.hidden = NO;
}
-(void)closeEditStatus{
    isSave = NO;
    sectionNum = 1;
    [self.columnCollectionView reloadData];
    [self hideNotAddView];

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
