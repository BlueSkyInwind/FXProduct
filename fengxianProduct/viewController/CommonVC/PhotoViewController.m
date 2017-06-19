//
//  PhotoViewController.m
//  TMHolterChildProject
//
//  Created by Wangyongxin on 16/7/4.
//  Copyright © 2016年 dk. All rights reserved.
//

#import "PhotoViewController.h"
#import "NewsViewModel.h"
#import "PhotoModel.h"
#import "ExplainView.h"

@interface PhotoViewController ()<UIScrollViewDelegate>{
    
    UIScrollView * backScrollView;
    
    NSInteger explainViewHeight;
    
}
@property (nonatomic,strong)PhotoModel * photoModel;
@property (nonatomic,strong)ExplainView * explainView;

@property (nonatomic,strong)NSMutableArray * photoArray;
@property (nonatomic,strong)NSMutableArray * explainArray;

@property (nonatomic,assign)NSInteger  selectPhoto;
@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"新闻详情";
    _selectPhoto = 1;
    [self addBackItem];
    __weak typeof (self) weakSelf = self;
    [self obtainDetail:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf configureView];
        }
    }];
}
-(void)viewWillDisappear:(BOOL)animated{
    
    if ([self.delegate respondsToSelector:@selector(delegatePhotoArray:)]) {
        [self.delegate delegatePhotoArray:self.photoArray];
    }
}
-(void)obtainDetail:(void(^)(BOOL isSuccess))finish{
    
    NewsViewModel * newViewM = [[NewsViewModel alloc]init];
    [newViewM setBlockWithReturnBlock:^(id returnValue) {
        self.photoModel = returnValue;
        self.photoArray = [self.photoModel.Images mutableCopy];
        self.explainArray = [NSMutableArray array];
        finish(YES);
    } WithFaileBlock:^{
        
    }];
    [newViewM fatchPhotoDeatailInfoID:[NSString stringWithFormat:@"%@",self.detailID]];
}
-(void)configureView
{
    backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h - 64)];
    if (self.photoArray.count != 0) {
        backScrollView.contentSize = CGSizeMake(_k_w * self.photoArray.count, _k_h - 64);
    }
    backScrollView.delegate =self;
    backScrollView.contentOffset = CGPointMake(_k_w * (self.selectPhoto - 1), 0);
    backScrollView.pagingEnabled= YES;
    backScrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backScrollView];
    [self AddImageViewArr];
    
    PhotoDetailModel * photoDetailM = self.photoModel.Images.firstObject;
    explainViewHeight =   [Tool heightForText:photoDetailM.Cont width:(_k_w - 25) font:14] + 66;
    self.explainView = [[NSBundle mainBundle]loadNibNamed:@"ExplainView" owner:self options:nil].lastObject;
    self.explainView.frame = CGRectMake(0, _k_h - 66, _k_w, explainViewHeight);
    self.explainView.titleLabel.text = self.photoModel.Title;
    self.explainView.imageNum.text = [NSString stringWithFormat:@"1/%@",self.photoModel.total];
    [self.view addSubview:self.explainView];
}
//-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    
//    NSInteger count = targetContentOffset->x  / (ScreenWidth + 10);
//    self.selectPhoto = count + 1;
////    backScrollView.contentOffset = CGPointMake(targetContentOffset->x + 10 * count, 0);
//    self.title = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)self.selectPhoto,(unsigned long)self.photoArray.count];
//    
//}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger count = scrollView.contentOffset.x  / _k_w;
    self.selectPhoto = count + 1;
    [UIView animateWithDuration:0 animations:^{
        backScrollView.contentOffset = CGPointMake((_k_w + 10) * count, 0);
    }];
    self.explainView.imageNum.text = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)self.selectPhoto,(unsigned long)self.photoArray.count];
    self.explainView.contentLabel.text = self.explainArray[self.selectPhoto -1];
}
-(void)AddImageViewArr{
    
    for (int i = 0; i < self.photoArray.count; i++) {
        PhotoDetailModel * photoDetailM = self.photoArray[i];
        [self.explainArray addObject:photoDetailM.Cont];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_w * 0.8)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:photoDetailM.Image] placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_1" ] options:SDWebImageRefreshCached];
        imageView.frame = CGRectMake(0, 0, _k_w, _k_w * imageView.image.size.height / imageView.image.size.width);
        imageView.center = CGPointMake(_k_w / 2  + (_k_w + 10) * i, (_k_h - 64) / 2);
        [backScrollView addSubview:imageView];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue ].
    // Pass the selected object to the new view controller.
}
*/

@end
