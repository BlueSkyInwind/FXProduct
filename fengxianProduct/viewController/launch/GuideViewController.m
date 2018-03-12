//
//  GuideViewController.m
//  fengxianProduct
//
//  Created by admin on 2017/6/29.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "GuideViewController.h"
#define _k_w [UIScreen mainScreen].bounds.size.width
#define _k_h [UIScreen mainScreen].bounds.size.height

NSString *const NewFeatureVersionKey = @"NewFeatureVersionKey";
@interface GuideViewController () <UIScrollViewDelegate>

@property (nonatomic,copy) void(^enterBlock)();

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIPageControl *pageControl;

@property (strong, nonatomic) UIButton *btn;

@property (strong, nonatomic) NSArray *imageArr;

@property (strong, nonatomic) NSArray *backgroundViews;
@end

@implementation GuideViewController

+ (instancetype)newGuideVCWithModels:(NSArray *)models enterBlock:(void(^)())enterBlock {
    GuideViewController *newLunchVC = [[GuideViewController alloc] init];
    newLunchVC.imageArr = models;
    newLunchVC.enterBlock = enterBlock;
    return newLunchVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initScrollview];
    [self initImageView];
    [self addCustomPage];
}
- (void)initScrollview
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    
    _scrollView.contentSize = CGSizeMake(screenSize.width * _imageArr.count, screenSize.height);
    
    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:_scrollView];
    
}
- (void)initImageView
{
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (int i = 0; i < _imageArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * _k_w, 0, _k_w, _k_h)];
//        [imageView sd_setImageWithURL:[_imageArr objectAtIndex:i]];
        [imageView setImage:[UIImage imageWithData:[_imageArr objectAtIndex:i]]];
        [tmpArr addObject:imageView];
    
        [self.scrollView addSubview:imageView];
    }
    
    self.backgroundViews = [[tmpArr reverseObjectEnumerator] allObjects];
}

- (void)addCustomPage
{
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.pageIndicatorTintColor = hexColorAlpha(42baff, 0.3);
    _pageControl.currentPageIndicatorTintColor = hexColor(42baff);
    _pageControl.numberOfPages = _imageArr.count;
    [self.view addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-40);
    }];
}

- (void)addButton
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"guide_icon"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.left.equalTo(@20);
        make.right.equalTo(@(-20));
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
}

- (void)click
{
    if (self.enterBlock != nil) {
        [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.view.alpha = 0;
        } completion:^(BOOL finished) {
            [self.view removeFromSuperview];
            _enterBlock();
        }];
    }
}
-(void)saveVersion{
    
    //系统直接读取的版本号
    NSString *versionValueStringForSystemNow=[Tool version];
    
    //保存版本号
    [[NSUserDefaults standardUserDefaults] setObject:versionValueStringForSystemNow forKey:NewFeatureVersionKey];
}


+(BOOL)canShowNewFeature{
    
    return YES;
    
    //系统直接读取的版本号
    NSString *versionValueStringForSystemNow=[Tool version];
    
    //读取本地版本号
    NSString *versionLocal = [[NSUserDefaults standardUserDefaults] objectForKey:NewFeatureVersionKey];
    
    if(versionLocal!=nil && [versionValueStringForSystemNow isEqualToString:versionLocal]){//说明有本地版本记录，且和当前系统版本一致
        
        return NO;
        
    }else{//无本地版本记录或本地版本记录与当前系统版本不一致
        
        //保存
        [[NSUserDefaults standardUserDefaults] setObject:versionValueStringForSystemNow forKey:NewFeatureVersionKey];
        
        return YES;
    }
}

#pragma mark --ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / _k_w;
    self.pageControl.currentPage = page;
  
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (velocity.x < 0) {
        return;
    }
    if (self.pageControl.currentPage+1 == _imageArr.count) {
        [self click];
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
