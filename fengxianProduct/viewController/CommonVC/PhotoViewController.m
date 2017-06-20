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
    
    BOOL isDispaly;
    
}
@property (nonatomic,strong)PhotoModel * photoModel;
@property (nonatomic,strong)ExplainView * explainView;

@property (nonatomic,strong)NSMutableArray * photoArray;
@property (nonatomic,strong)NSMutableArray * explainArray;

@property (nonatomic,assign)NSInteger  selectPhoto;
@property (nonatomic,strong) UIPageControl *pageControl;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"新闻详情";
    _selectPhoto = 0;
    isDispaly= YES;
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
        backScrollView.contentSize = CGSizeMake(_k_w * self.photoArray.count, 0);
    }
    backScrollView.delegate =self;
    backScrollView.contentOffset = CGPointMake(_k_w * (self.selectPhoto - 1), 0);
    backScrollView.bounces = NO;
    backScrollView.pagingEnabled= YES;
    backScrollView.backgroundColor = [UIColor blackColor];
    [backScrollView setContentOffset:CGPointMake(_selectPhoto*self.view.bounds.size.width, 0)] ;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backScrollViewClick)];
    [backScrollView addGestureRecognizer:tap];
    
    [self.view addSubview:backScrollView];
    
    self.pageControl=[[UIPageControl alloc] init];
    self.pageControl.backgroundColor=[UIColor clearColor];
    [self.pageControl setBounds:CGRectMake(0, 0,200, 100)];
    [self.pageControl setCenter:CGPointMake(_k_w/2,_k_h/2+200.0)];
    self.pageControl.numberOfPages=[self.photoArray count];
    self.pageControl.currentPage=0;
    [self.pageControl addTarget:self action:@selector(switchPage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    
    [self AddImageViewArr];
    [self addExplainView];
}
-(void)addExplainView{
    
    PhotoDetailModel * photoDetailM = self.photoArray[self.selectPhoto];
    explainViewHeight =  [Tool heightForText:photoDetailM.Cont width:(_k_w - 25) font:14] + 66;
    
    if (!self.explainView) {
        self.explainView = [[NSBundle mainBundle]loadNibNamed:@"ExplainView" owner:self options:nil].lastObject;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(explainViewClick)];
        [self.explainView addGestureRecognizer:tap];

        self.explainView.alpha = 0.5;
        [self.view addSubview:self.explainView];

    }
    self.explainView.frame = CGRectMake(0, _k_h - explainViewHeight - 44, _k_w, explainViewHeight);
    self.explainView.titleLabel.text = self.photoModel.Title;
    self.explainView.imageNum.text = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)self.selectPhoto+1,(unsigned long)self.photoArray.count];
    self.explainView.photoDetailModel = self.photoArray[self.selectPhoto];
}
-(void)explainViewClick{
    
    
    
    
    
}
-(void)backScrollViewClick{
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        if (isDispaly) {
            self.explainView.frame = CGRectMake(0, 2 * _k_h , _k_w, explainViewHeight);
            self.explainView.hidden = YES;
            
        }else{
            [self addExplainView];
            self.explainView.hidden = NO;
        }
    } completion:^(BOOL finished) {
        isDispaly = !isDispaly;

    }];
}
- (void)switchPage:(id)sender{
    UIPageControl *currentControl=(UIPageControl *)sender;
    NSInteger currentPage=currentControl.currentPage;
    [backScrollView setContentOffset:CGPointMake(currentPage*self.view.bounds.size.width, 0)] ;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger count = scrollView.contentOffset.x  / _k_w;
    [self.pageControl setCurrentPage:count];
    self.selectPhoto = count;
    
    self.explainView.imageNum.text = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)self.selectPhoto+1,(unsigned long)self.photoArray.count];
    self.explainView.photoDetailModel = self.photoArray[self.selectPhoto];
    if (!self.explainView.hidden) {
        [self addExplainView];
    }
}
-(void)AddImageViewArr{
    
    for (int i = 0; i < self.photoArray.count; i++) {
        PhotoDetailModel * photoDetailM = self.photoArray[i];
        [self.explainArray addObject:photoDetailM.Cont];
       __block UIImageView * imageView = [[UIImageView alloc]init];
        imageView.contentMode =UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
//        [imageView sd_setImageWithURL:[NSURL URLWithString:photoDetailM.Image] placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_1" ] options:SDWebImageRefreshCached];
        [self loadImageWithUrl:photoDetailM.Image imageView:imageView completed:^(UIImage *image) {
            imageView.image = image;
            imageView.frame =  CGRectMake(0, 0, _k_w, _k_w * image.size.height / image.size.width);
            imageView.userInteractionEnabled = YES;
            imageView.center = CGPointMake(_k_w / 2  + (_k_w) * i, (_k_h - 64) / 2);
            [backScrollView addSubview:imageView];
        }];
    }
}

-(void)loadImageWithUrl:(NSString *)str imageView:(UIImageView *)imageView completed:(void(^)(UIImage * image))completedLoad{
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:str]
                 placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_1" ]
                          options:SDWebImageAvoidAutoSetImage // 下载完成后不要自动设置image
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    completedLoad(image);
                                });
                        }];
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
