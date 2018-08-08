//
//  LaunchViewController.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/6.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "LaunchViewController.h"
#import <WebKit/WebKit.h>
#import "NewsViewModel.h"
#import "GuideModel.h"
#import "FLAnimatedImageView.h"

@interface LaunchViewController (){
    
    WKWebView *webViewOne;

    UIWebView * webViewTwo;

}
@property (nonatomic,strong)FLAnimatedImageView * animatedImageView;

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 设定位置和大小
    [self obtainGuideImage];
    [[ShareConfig share]obtainNewsColumnInfo:^(BOOL isSuccess) {
        
    }];

    CGRect frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    CGSize launchSize = [UIImage imageNamed:@"launch_Image3.gif"].size;
    frame.size = launchSize;
    frame.size.width = launchSize.width / 2;
    frame.size.height = launchSize.height / 2;
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"launch_Image3" ofType:@"gif"]];
    // view生成
    
    __weak typeof (self) weakSelf = self;
    self.animatedImageView = [[FLAnimatedImageView alloc]initWithFrame:frame];
    self.animatedImageView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:gif];
    [self.view addSubview:self.animatedImageView];
    self.animatedImageView.loopCompletionBlock = ^(NSUInteger loopCountRemaining) {
        [weakSelf.animatedImageView stopAnimating];
    };
    
//    if ([UIDevice  systemVersion] > 9.0) {
//
//        webViewOne = [[WKWebView alloc] initWithFrame:frame];
//        webViewOne.userInteractionEnabled = NO;//用户不可交互
//        [webViewOne loadData:gif MIMEType:@"image/gif"  characterEncodingName:nil baseURL:nil];
//        [self.view addSubview:webViewOne];
//    }else{
//        webViewTwo = [[UIWebView alloc] initWithFrame:frame];
//        webViewTwo.scalesPageToFit = YES;
//        webViewTwo.userInteractionEnabled = NO;//用户不可交互
//        [webViewTwo loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//        [self.view addSubview:webViewTwo];
//    }
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    webViewTwo = nil;
    webViewOne = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)obtainGuideImage{
    NewsViewModel * newsViewM = [[NewsViewModel alloc]init];
    [newsViewM setBlockWithReturnBlock:^(id returnValue) {
        NSMutableArray * guideArr = [[Tool getContentWithKey:FX_GuideImageArr] mutableCopy];
        if (guideArr) {
            [guideArr removeAllObjects];
        }else{
            guideArr = [NSMutableArray array];
        }
    
        for (int i = 0; i <  app.guideImageArr.count; i++) {
            
            [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:app.guideImageArr[i]] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                NSLog(@"%ld",cacheType);
                if (cacheType == 0 && data) {
                    [guideArr addObject:data];
                    [Tool saveUserDefaul:guideArr Key:FX_GuideImageArr];
                }
            }];
        }
    } WithFaileBlock:^{
        
    }];
    [newsViewM obtainGuideImage];
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
