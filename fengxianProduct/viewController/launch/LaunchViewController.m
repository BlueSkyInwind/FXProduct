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

@interface LaunchViewController (){
    
    WKWebView *webViewOne;

    UIWebView * webViewTwo;

}

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
    if ([UIDevice  systemVersion] > 9.0) {
        
        webViewOne = [[WKWebView alloc] initWithFrame:frame];
        webViewOne.userInteractionEnabled = NO;//用户不可交互
        [webViewOne loadData:gif MIMEType:@"image/gif"  characterEncodingName:nil baseURL:nil];
        [self.view addSubview:webViewOne];
    }else{
        
        webViewTwo = [[UIWebView alloc] initWithFrame:frame];
        webViewTwo.scalesPageToFit = YES;
        webViewTwo.userInteractionEnabled = NO;//用户不可交互
        [webViewTwo loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
        [self.view addSubview:webViewTwo];
        
    }
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
