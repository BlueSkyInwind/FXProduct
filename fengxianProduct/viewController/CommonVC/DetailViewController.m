//
//  DetailViewController.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/18.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailHeaderView.h"
#import <WebKit/WebKit.h>
#import "NewsViewModel.h"
#import "DetailModel.h"
@interface DetailViewController ()<WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate>{
    NSMutableArray * commenArray;
}

@property (nonatomic,strong)DetailHeaderView * detailHeaderView;
@property (nonatomic,strong)WKWebView * contentWebView;
@property (nonatomic,strong)UIScrollView * backScrollView;
@property (nonatomic,strong)DetailModel * detailModel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"新闻详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;

    [self addBackItem];
    commenArray = [NSMutableArray array];
    __weak typeof (self) weakSelf = self;
    [self obtainDetail:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf configureView];
        }
    }];
    
}
-(void)obtainDetail:(void(^)(BOOL isSuccess))finish{
    
    NewsViewModel * newViewM = [[NewsViewModel alloc]init];
    [newViewM setBlockWithReturnBlock:^(id returnValue) {
        self.detailModel = returnValue;
        finish(YES);
    } WithFaileBlock:^{
        
    }];
    [newViewM fatchDeatailInfoID:[NSString stringWithFormat:@"%@",self.detailID]];
    
}
-(void)configureView{
    
    
    _backScrollView = [[UIScrollView alloc]init];
    _backScrollView.backgroundColor = [UIColor whiteColor];
    self.backScrollView.contentSize = CGSizeMake(_k_w, 2 * _k_h);
    [self.view addSubview:_backScrollView];
    [_backScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    self.detailHeaderView = [[NSBundle mainBundle]loadNibNamed:@"DetailHeaderView" owner:self options:nil].lastObject;
    self.detailHeaderView.titleLabel.text = self.detailModel.Title;
    self.detailHeaderView.timeLabel.text = self.detailModel.Time;
    self.detailHeaderView.autherLabel.text = self.detailModel.Auther;
    self.detailHeaderView.sourceLabel.text = self.detailModel.Source;
    [self.backScrollView addSubview:self.detailHeaderView];
    [self.detailHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(64);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@90);
    }];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences = [[WKPreferences alloc] init];
    config.preferences.javaScriptEnabled = true;
    config.preferences.javaScriptCanOpenWindowsAutomatically = true;
    config.userContentController = [[WKUserContentController alloc] init];
    
    _contentWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    _contentWebView.navigationDelegate = self;
    _contentWebView.UIDelegate = self;
    _contentWebView.scrollView.contentSize = self.view.bounds.size;
    [self.backScrollView addSubview:_contentWebView];
    _contentWebView.scrollView.showsHorizontalScrollIndicator = false;
    _contentWebView.scrollView.showsVerticalScrollIndicator = false;
    [_contentWebView loadHTMLString:self.detailModel.Information baseURL:nil];
    [self.contentWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailHeaderView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(_k_h));
    }];


}


//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    
//    [webView evaluateJavaScript:@"document.getElementById(\"content\").offsetHeight;" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//        //获取页面高度，并重置webview的frame
//        CGFloat documentHeight = [result doubleValue];
//        CGRect frame = webView.frame;
//        frame.size.height = documentHeight;
//        webView.frame = frame;
//       self.backScrollView.contentSize = CGSizeMake(_k_w, 90 + frame.size.height);
//    }];
//}
//
// 类似 UIWebView的 -webView: shouldStartLoadWithRequest: navigationType:
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURLRequest *request = navigationAction.request;
    NSLog(@"=========%@",request.URL.absoluteString);
    decisionHandler(WKNavigationActionPolicyAllow);
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
