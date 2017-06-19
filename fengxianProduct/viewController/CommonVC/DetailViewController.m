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
#import "DetailButtomView.h"

@interface DetailViewController ()<WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate,UIWebViewDelegate>{
    NSMutableArray * commenArray;
    
    NSInteger commentViewHieight;
}

@property (nonatomic,strong)DetailHeaderView * detailHeaderView;
@property (nonatomic,strong)UIWebView * contentWebView;
@property (nonatomic,strong)UIScrollView * backScrollView;
@property (nonatomic,strong)DetailModel * detailModel;
@property (nonatomic,strong) UIView * view2;
@property (nonatomic,strong) DetailButtomView * detailButtomView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"新闻详情";
    commentViewHieight = 170;
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
#pragma mark - 新闻详情布局
-(void)configureView{
    
    _backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
    _backScrollView.backgroundColor = [UIColor whiteColor];
    self.backScrollView.contentSize = CGSizeMake(_k_w, _k_h);
//    _backScrollView.showsHorizontalScrollIndicator = false;
//    _backScrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:_backScrollView];
    
    self.detailHeaderView = [[NSBundle mainBundle]loadNibNamed:@"DetailHeaderView" owner:self options:nil].lastObject;
    self.detailHeaderView.frame = CGRectMake(0, 64, _k_w, 90);
    self.detailHeaderView.titleLabel.text = self.detailModel.Title;
    self.detailHeaderView.timeLabel.text = self.detailModel.Time;
    self.detailHeaderView.autherLabel.text = self.detailModel.Auther;
    self.detailHeaderView.sourceLabel.text = self.detailModel.Source;
    self.detailHeaderView.userInteractionEnabled = YES;
    [_backScrollView addSubview:self.detailHeaderView];

//    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
//    config.preferences = [[WKPreferences alloc] init];
//    config.preferences.javaScriptEnabled = true;
//    config.preferences.javaScriptCanOpenWindowsAutomatically = true;
//    config.ignoresViewportScaleLimits = YES;
//    config.userContentController = [[WKUserContentController alloc] init];
    //    _contentWebView.navigationDelegate = self;
    //    _contentWebView.UIDelegate = self;
    if ([self.Species integerValue] == 3) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 165, _k_w, 200)];
        view.backgroundColor = [UIColor blackColor];
        [_backScrollView addSubview:view];
        
        _contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 365, _k_w, _k_h)];
    }else{
        _contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 154, _k_w, _k_h)];
    }
    _contentWebView.scrollView.scrollEnabled =  NO;
    [_contentWebView.scrollView setZoomScale:2.0 animated:YES];
    _contentWebView.delegate = self;
    [_backScrollView addSubview:_contentWebView];
    [_contentWebView loadHTMLString:self.detailModel.Information baseURL:nil];
    
//    _view2 = [[UIView alloc]initWithFrame:CGRectMake(0, _contentWebView.frame.size.height + 10, _k_w, 100)];
//    _view2.backgroundColor = [UIColor redColor];
//    [_backScrollView addSubview:_view2];
    
    DetailCommentModel * detailCommentM = self.detailModel.rows.firstObject;
    if (detailCommentM.Reply) {
        commentViewHieight  += 60;
    }
    DetailCommentModel * detailCommentM2 = [[DetailCommentModel alloc]initWithDictionary:detailCommentM.lower error:nil];
    if ([detailCommentM2.success integerValue] == 1) {
        commentViewHieight  += 90;
    }
    self.detailButtomView = [[NSBundle mainBundle]loadNibNamed:@"DetailButtomView" owner:self options:nil].lastObject;
    self.detailButtomView.frame = CGRectMake(0, _contentWebView.frame.size.height + 10, _k_w, commentViewHieight);
    self.detailButtomView.detailCommentModel =  self.detailModel.rows.firstObject;
    [self.backScrollView addSubview:self.detailButtomView];

}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat documentHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    CGRect frame = webView.frame;
    frame.size.height = documentHeight + 10;
    webView.frame = frame;
   self.detailButtomView.frame = CGRectMake(0, _contentWebView.frame.size.height + 154, _k_w, commentViewHieight);
    self.backScrollView.contentSize = CGSizeMake(_k_w, 190 + documentHeight + 30 + commentViewHieight);

    [self.view layoutSubviews];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        //获取页面高度，并重置webview的frame
        CGFloat documentHeight = [result doubleValue];
        CGRect frame = webView.frame;
        frame.size.height = documentHeight;
        webView.frame = frame;

       self.backScrollView.contentSize = CGSizeMake(_k_w, 90 + frame.size.height);
    }];
}

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