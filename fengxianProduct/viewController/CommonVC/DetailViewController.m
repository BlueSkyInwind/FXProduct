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
#import "CommonBottomView.h"
#import "CommentDetailViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import "SBPlayer.h"
#import "CommentInputView.h"
#import "PopCommentInput.h"
#import "NewsDetailStatusModel.h"
@interface DetailViewController ()<WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate,UIWebViewDelegate,CommonBottomViewDelegate,DetailButtomViewDelegate,UITextViewDelegate>{
    NSMutableArray * commenArray;
    
    NSInteger commentViewHieight;
    
    float commentInputViewHeight;
    
    UIImage * shareImage;
    
}

@property (nonatomic,strong)DetailHeaderView * detailHeaderView;
@property (nonatomic,strong)UIWebView * contentWebView;
@property (nonatomic,strong)UIScrollView * backScrollView;
@property (nonatomic,strong)DetailModel * detailModel;
@property (nonatomic,strong)UIView * vedioPlayerView;
@property (nonatomic,strong) DetailButtomView * detailButtomView;
@property (nonatomic,strong) CommonBottomView * commonBottomView;
@property (nonatomic,strong) SBPlayer *player;
@property (nonatomic,strong)CommentInputView * commentInputView;
@property (nonatomic,strong)UIView * maskView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"新闻详情";
    commentViewHieight = 170;
    commentInputViewHeight = 100;
    if (UI_IS_IPHONE6P) {
        commentInputViewHeight = 150;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    [self addBackItem];
    
    commenArray = [NSMutableArray array];
    __weak typeof (self) weakSelf = self;
    [self obtainDetail:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf obtainCollectAndSpotStatus];
            [weakSelf configureView];
        }
    }];
}
-(void)viewWillDisappear:(BOOL)animated{
//    self.player
    
}
-(void)dealloc{
    [self.player removeFromSuperview];
    self.player = nil;
}


#pragma mark - 网络请求
-(void)obtainCollectAndSpotStatus{
    if (![Utility sharedUtility].loginFlage) {
        return ;
    }
    NewsViewModel * newViewM = [[NewsViewModel alloc]init];
    [newViewM setBlockWithReturnBlock:^(id returnValue) {
        NewsDetailStatusModel * newsDetailStatusModel  = returnValue;
        if ([newsDetailStatusModel.Collections boolValue]) {
            [self.commonBottomView.collectBtn setBackgroundImage:[UIImage imageNamed:@"Collect_Icon_blue"] forState:UIControlStateNormal];
        }else{
            [self.commonBottomView.spotBtn setBackgroundImage:[UIImage imageNamed:@"Collect_Icon_gray"] forState:UIControlStateNormal];
        }
        
        if ([newsDetailStatusModel.Thumbs boolValue]) {
            [self.commonBottomView.spotBtn setBackgroundImage:[UIImage imageNamed:@"Dianzan_blue"] forState:UIControlStateNormal];
        }else{
            [self.commonBottomView.spotBtn setBackgroundImage:[UIImage imageNamed:@"Dianzan_gray"] forState:UIControlStateNormal];
        }
    } WithFaileBlock:^{
        
    }];
    [newViewM fatchNewsCollectAndSpotStatusID:[NSString stringWithFormat:@"%@",self.detailID] type:@"8"];
}
-(void)getShareImage{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:self.detailModel.Images]];
        UIImage *image = [[UIImage alloc]initWithData:data];
        if (data != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //在这里做UI操作(UI操作都要放在主线程中执行)
                shareImage = [image copy];
            });
        }
        
    });
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
-(void)requestSpotAndCollect:(NSString *)type{
    NewsViewModel * newViewM = [[NewsViewModel alloc]init];
    [newViewM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:(NSString *)returnMsg.msg];
            NSString * str = (NSString *)returnMsg.msg;
            if ([str isEqualToString:@"点赞成功！"] ) {
                [self.commonBottomView.spotBtn setBackgroundImage:[UIImage imageNamed:@"Dianzan_blue"] forState:UIControlStateNormal];
                int num = [self.detailButtomView.spotNum.text intValue];
                self.detailButtomView.spotNum.text = [NSString stringWithFormat:@"%d",(num + 1)];
            }else if([str isEqualToString:@"取消点赞成功！"]){
                [self.commonBottomView.spotBtn setBackgroundImage:[UIImage imageNamed:@"Dianzan_gray"] forState:UIControlStateNormal];
                int num = [self.detailButtomView.spotNum.text intValue];
                self.detailButtomView.spotNum.text = [NSString stringWithFormat:@"%d",(num - 1)];
            }
        }
    } WithFaileBlock:^{
        
    }];
    [newViewM fatchCollectAndSpotStatus:type ceteID:[NSString stringWithFormat:@"8:%@",self.detailID]];
}

#pragma mark - 底部tab点击代理 时间
-(void)commentButtonClick{

    if ([[ShareConfig share] isPresentLoginVC:self]) {
        if (self.detailModel.rows.count == 0 || !self.detailModel.rows) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"该新闻尚无评论"];
            return;
        }
        CommentDetailViewController * commentDetailVC = [[CommentDetailViewController alloc]init];
        commentDetailVC.detailModel = self.detailModel;
        commentDetailVC.detailID = self.detailID;
        [self.navigationController pushViewController:commentDetailVC animated:YES];
    }
}
- (void)spotButtonClick{
    if (![[ShareConfig share] isPresentLoginVC:self]) {
        return;
    }
    [self requestSpotAndCollect:@"1"];
}
- (void)collectButtonClick{
    if (![[ShareConfig share] isPresentLoginVC:self]) {
        return;
    }
    NewsViewModel * newViewM = [[NewsViewModel alloc]init];
    [newViewM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:(NSString *)returnMsg.msg];
            NSString * str = (NSString *)returnMsg.msg;
            if ([str isEqualToString:@"收藏成功！"] ) {
                [self.commonBottomView.collectBtn setBackgroundImage:[UIImage imageNamed:@"Collect_Icon_blue"] forState:UIControlStateNormal];
            }else if([str isEqualToString:@"取消收藏成功！"]){
                [self.commonBottomView.collectBtn setBackgroundImage:[UIImage imageNamed:@"Collect_Icon_gray"] forState:UIControlStateNormal];
            }
        }
    } WithFaileBlock:^{
        
    }];
    [newViewM fatchCollectAndSpotStatus:@"0" ceteID:[NSString stringWithFormat:@"8:%@",self.detailID]];
}
- (void)shareButtonClick{
    [self shareContent:self.detailModel.Share Title:self.detailModel.Title];
}
- (void)inputCommentTap{
    if (![[ShareConfig share] isPresentLoginVC:self]) {
        return;
    }
//    [self showCommentView];
    PopCommentInput * popComment = [PopCommentInput share];
    popComment.detailID = self.detailID;
    popComment.commentId = @"0";
    [popComment showCommentView];
}
#pragma mark - 页面底部评论区点击事件
-(void)DetailSpotButtonClick{
    if (![[ShareConfig share] isPresentLoginVC:self]) {
        return;
    }
    [self requestSpotAndCollect:@"1"];
}
#pragma mark - 新闻详情布局
-(void)configureView{
    
    [self getShareImage];
    _backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h - 40)];
    _backScrollView.backgroundColor = [UIColor whiteColor];
    self.backScrollView.contentSize = CGSizeMake(_k_w, _k_h);
//    _backScrollView.showsHorizontalScrollIndicator = false;
//    _backScrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:_backScrollView];
    
    self.commonBottomView = [[NSBundle mainBundle]loadNibNamed:@"CommonBottomView" owner:self options:nil].lastObject;
    self.commonBottomView.frame = CGRectMake(0, _k_h - 40, _k_w, 40);
    self.commonBottomView.delegate = self;
    [self.view addSubview:self.commonBottomView];

    self.detailHeaderView = [[NSBundle mainBundle]loadNibNamed:@"DetailHeaderView" owner:self options:nil].lastObject;
    self.detailHeaderView.frame = CGRectMake(0, 64, _k_w, 90);
    self.detailHeaderView.titleLabel.text = self.detailModel.Title;
    self.detailHeaderView.timeLabel.text = self.detailModel.Time;
    self.detailHeaderView.autherLabel.text = self.detailModel.Auther;
    if ([self.detailModel.Source isEqualToString:@"原创"]) {
        self.detailHeaderView.sourceLabel.textColor = [UIColor redColor];
    }
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
        //添加视频播放发的视图
        [self initVedioPalyView];
        
        _contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 365, _k_w, _k_h)];
    }else{
        _contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 154, _k_w, _k_h)];
    }
    _contentWebView.scrollView.scrollEnabled =  NO;
    [_contentWebView.scrollView setZoomScale:2.0 animated:YES];
    _contentWebView.delegate = self;
    [_backScrollView addSubview:_contentWebView];
    [_contentWebView loadHTMLString:self.detailModel.Information baseURL:nil];
        
    DetailCommentModel * detailCommentM = self.detailModel.rows.firstObject;
    //小编回复
    if (detailCommentM.Reply) {
        commentViewHieight  += 60;
    }
    //二级评论
    DetailCommentModel * detailCommentM2 = [[DetailCommentModel alloc]initWithDictionary:detailCommentM.lower error:nil];
    if ([detailCommentM2.success integerValue] == 1) {
        commentViewHieight  += 90;
    }
    if (self.detailModel.rows.count == 0) {
        commentViewHieight -= 100;
    }
    self.detailButtomView = [[NSBundle mainBundle]loadNibNamed:@"DetailButtomView" owner:self options:nil].lastObject;
    self.detailButtomView.frame = CGRectMake(0, _contentWebView.frame.size.height + 10, _k_w, commentViewHieight);
    self.detailButtomView.detailCommentModel =  self.detailModel.rows.firstObject;
    self.detailButtomView.detailID = self.detailID;
    self.detailButtomView.delegate = self;
    self.detailButtomView.browerNum.text = [NSString stringWithFormat:@"%@",self.detailModel.Num];
    self.detailButtomView.spotNum.text = [NSString stringWithFormat:@"%@",self.detailModel.ThNum];
    [self.backScrollView addSubview:self.detailButtomView];

}
-(void)initVedioPalyView{
    
//    _vedioPlayerView = [[UIView alloc]initWithFrame:CGRectMake(0, 165, _k_w, 200)];
//    _vedioPlayerView.backgroundColor = [UIColor blackColor];
//    [_backScrollView addSubview:_vedioPlayerView];
    self.player = [[SBPlayer alloc]initWithUrl:[NSURL URLWithString:self.detailModel.MP4]];
    //设置标题
    self.player.frame = CGRectMake(0, 165, _k_w, 200);
    [self.player setTitle:@""];
    //设置播放器背景颜色
    self.player.backgroundColor = [UIColor blackColor];
    //设置播放器填充模式 默认SBLayerVideoGravityResizeAspectFill，可以不添加此语句
    self.player.mode = SBLayerVideoGravityResize;
    //添加播放器到视图
    [_backScrollView addSubview:self.player];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat documentHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    CGRect frame = webView.frame;
    frame.size.height = documentHeight + 10;
    webView.frame = frame;
    if ([self.Species integerValue] == 3) {
        self.detailButtomView.frame = CGRectMake(0, _contentWebView.frame.size.height + 364, _k_w, commentViewHieight);
        self.backScrollView.contentSize = CGSizeMake(_k_w, 390 + documentHeight + 30 + commentViewHieight);
    }else{
        self.detailButtomView.frame = CGRectMake(0, _contentWebView.frame.size.height + 154, _k_w, commentViewHieight);
        self.backScrollView.contentSize = CGSizeMake(_k_w, 190 + documentHeight + 30 + commentViewHieight);
    }

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


//分享函数
-(void)shareContent:(NSString*)urlStr Title:(NSString *)title
{
    if (!shareImage) {
        shareImage = [UIImage imageNamed:@"logo_share"];
    }
     NSArray *imageArr = @[shareImage];
  
    if (imageArr) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@""
                                         images:imageArr
                                            url:[NSURL URLWithString:urlStr]
                                          title:title
                                           type:SSDKContentTypeAuto];
        [shareParams SSDKEnableUseClientShare];
        [ShareSDK showShareActionSheet:nil
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess:
                               [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"分享成功"];
                               break;
                               
                           case SSDKResponseStateFail:
                               [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"分享失败"];
                           default:
                               break;
                       }
                   }];
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
