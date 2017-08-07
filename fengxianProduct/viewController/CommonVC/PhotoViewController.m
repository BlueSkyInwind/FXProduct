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
#import "CommonBottomView.h"
#import "PopCommentInput.h"
#import "CommentDetailViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import "UIImage+Color.h"
#import "NewsDetailStatusModel.h"

@interface PhotoViewController ()<UIScrollViewDelegate,CommonBottomViewDelegate>{
    
    UIScrollView * backScrollView;
    
    NSInteger explainViewHeight;
    
    BOOL isDispaly;
    BOOL isDispalyAll;

    
    UIImage * shareImage;
    
}
@property (nonatomic,strong)PhotoModel * photoModel;
@property (nonatomic,strong)ExplainView * explainView;

@property (nonatomic,strong)NSMutableArray * photoArray;
@property (nonatomic,strong)NSMutableArray * explainArray;

@property (nonatomic,assign)NSInteger  selectPhoto;
@property (nonatomic,strong)UIPageControl *pageControl;

@property (nonatomic,strong)CommonBottomView *  commonBottomView;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"新闻详情";
    _selectPhoto = 0;
    isDispaly= YES;
    isDispalyAll= NO;
    [self addBackItem];
    __weak typeof (self) weakSelf = self;
    [self obtainDetail:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf obtainCollectAndSpotStatus];
            [weakSelf configureView];
        }
    }];
}
-(void)viewWillDisappear:(BOOL)animated{
    
    if ([self.delegate respondsToSelector:@selector(delegatePhotoArray:)]) {
        [self.delegate delegatePhotoArray:self.photoArray];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [self commentUnreadStatus];
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
            [self.commonBottomView.spotBtn setBackgroundImage:[UIImage imageNamed:@"tab_dianzan_Icon_Blue"] forState:UIControlStateNormal];
        }else{
            [self.commonBottomView.spotBtn setBackgroundImage:[UIImage imageNamed:@"tab_dianzan_Icon_gray"] forState:UIControlStateNormal];
        }
    } WithFaileBlock:^{
        
    }];
    [newViewM fatchNewsCollectAndSpotStatusID:[NSString stringWithFormat:@"%@",self.detailID] type:@"8"];
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
-(void)commentUnreadStatus{
    NSMutableDictionary * dic = [[Tool getContentWithKey:FX_CommentTimeInfo] mutableCopy];
    if (dic) {
        NSString * str = [dic objectForKey:[NSString stringWithFormat:@"%@",self.detailID]];
        if ([str isEqualToString:self.photoModel.LastReplyTime]) {
            self.commonBottomView.CommentViewIcon.hidden = YES;
        }else{
            self.commonBottomView.CommentViewIcon.hidden = NO;
        }
    }
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
    [self.pageControl setBounds:CGRectMake(0, 0,0, 0)];
    [self.pageControl setCenter:CGPointMake(_k_w,_k_h)];
    self.pageControl.numberOfPages=[self.photoArray count];
    self.pageControl.currentPage=0;
    [self.pageControl addTarget:self action:@selector(switchPage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    
    [self AddImageViewArr];
    [self addExplainView];
    
    self.commonBottomView = [[NSBundle mainBundle]loadNibNamed:@"CommonBottomView" owner:self options:nil].lastObject;
    self.commonBottomView.frame = CGRectMake(0, _k_h - 40, _k_w, 40);
    self.commonBottomView.backgroundColor = [UIColor blackColor];
    self.commonBottomView.delegate = self;
    self.commonBottomView.cuttingLine.hidden = NO;
//    self.moblielcon.image = [[UIImage imageNamed:@"1_Signin_icon_01"] imageWithTintColor:UI_MAIN_COLOR];
    [self.commonBottomView.collectBtn setBackgroundImage: [[UIImage imageNamed:@"Collect_Icon_gray"] imageWithTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.commonBottomView.spotBtn setBackgroundImage: [[UIImage imageNamed:@"tab_dianzan_Icon_gray"] imageWithTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.commonBottomView.shareBtn setBackgroundImage: [[UIImage imageNamed:@"share_Icon"] imageWithTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.commonBottomView.commentImageView setImage:[[UIImage imageNamed:@"comment_click_ICon"] imageWithTintColor:[UIColor whiteColor]]];
    self.commonBottomView.defaultLabel.textColor = [UIColor whiteColor];
    [self.commonBottomView.commentImageView setImage:[UIImage imageNamed:@"comment_click_ICon_black"]];
    [self.view addSubview:self.commonBottomView];
    [self commentUnreadStatus];
    
}
-(void)addExplainView{
    
    explainViewHeight = 80;

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
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        if (isDispaly) {
            if (isDispalyAll) {
                [self addExplainView];
                self.explainView.hidden = NO;
            }else{
                PhotoDetailModel * photoDetailM = self.photoArray[self.selectPhoto];
                explainViewHeight =  [Tool heightForText:photoDetailM.Cont width:(_k_w - 25) font:14] + 66;

                self.explainView.frame = CGRectMake(0, _k_h - explainViewHeight - 44 , _k_w, explainViewHeight);
            }
        }
    } completion:^(BOOL finished) {
        isDispalyAll = !isDispalyAll;
    }];

}
#pragma mark - 底部tab点击代理 时间
-(void)commentButtonClick{
    if (![[ShareConfig share] isPresentLoginVC:self]) {
        return;
    }
    CommentDetailViewController * commentDetailVC = [[CommentDetailViewController alloc]init];
    commentDetailVC.detailID = self.detailID;
    [self.navigationController pushViewController:commentDetailVC animated:YES];
    
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
                [self.commonBottomView.spotBtn setBackgroundImage:[UIImage imageNamed:@"Collect_Icon_gray"] forState:UIControlStateNormal];
            }
        }
    } WithFaileBlock:^{
        
    }];
    [newViewM fatchCollectAndSpotStatus:@"0" ceteID:[NSString stringWithFormat:@"8:%@",self.detailID]];
}
- (void)shareButtonClick{
    [self shareContent:self.photoModel.Share Title:self.photoModel.Title];
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
-(void)requestSpotAndCollect:(NSString *)type{
    NewsViewModel * newViewM = [[NewsViewModel alloc]init];
    [newViewM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:(NSString *)returnMsg.msg];
            NSString * str = (NSString *)returnMsg.msg;
            if ([str isEqualToString:@"点赞成功！"] ) {
                [self.commonBottomView.spotBtn setBackgroundImage:[UIImage imageNamed:@"Dianzan_blue"] forState:UIControlStateNormal];
            }else if([str isEqualToString:@"取消点赞成功！"]){
                [self.commonBottomView.spotBtn setBackgroundImage:[UIImage imageNamed:@"tab_dianzan_Icon_gray"] forState:UIControlStateNormal];
            }
        }
    } WithFaileBlock:^{
        
    }];
    [newViewM fatchCollectAndSpotStatus:type ceteID:[NSString stringWithFormat:@"8:%@",self.detailID]];
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
       __block FLAnimatedImageView * imageView = [[FLAnimatedImageView alloc]init];
        imageView.contentMode =UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        if ([photoDetailM.Image hasSuffix:@".gif"]) {
            imageView.image = [UIImage imageNamed:@"news_placeholder_Icon_1" ];
            [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:photoDetailM.Image]  options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                if (i == 0) {
                    shareImage = [image copy];
                }
                imageView.image = nil;
                imageView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
                imageView.frame =  CGRectMake(0, 0, _k_w, _k_w * image.size.height / image.size.width);
                imageView.userInteractionEnabled = YES;
                imageView.center = CGPointMake(_k_w / 2  + (_k_w) * i, (_k_h - 64) / 2);
                [backScrollView addSubview:imageView];
            }];
        }else{
            [self loadImageWithUrl:photoDetailM.Image imageView:imageView completed:^(UIImage *image) {
                if (i == 0) {
                    shareImage = [image copy];
                }                 imageView.image = image;
                imageView.frame =  CGRectMake(0, 0, _k_w, _k_w * image.size.height / image.size.width);
                imageView.userInteractionEnabled = YES;
                imageView.center = CGPointMake(_k_w / 2  + (_k_w) * i, (_k_h - 64) / 2);
                [backScrollView addSubview:imageView];
            }];
        }
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
//分享函数
-(void)shareContent:(NSString*)urlStr Title:(NSString *)title
{
    if (!shareImage) {
        shareImage = [UIImage imageNamed:@"logo_share"];
    }
    NSArray *imageArr = @[shareImage];
    if (imageArr) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@,链接:%@",title,urlStr]
                                         images:imageArr
                                            url:[NSURL URLWithString:urlStr]
                                          title:@"IN奉贤"
                                           type:SSDKContentTypeAuto];
        [shareParams SSDKSetupSinaWeiboShareParamsByText:[NSString stringWithFormat:@"%@,链接:%@",title,urlStr] title:@"IN奉贤" image:shareImage url:[NSURL URLWithString:urlStr] latitude:0 longitude:0 objectID:nil type:SSDKContentTypeAuto];
        [shareParams SSDKEnableUseClientShare];
      SSUIShareActionSheetController * sheet =  [ShareSDK showShareActionSheet:nil
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               if (platformType == SSDKPlatformTypeCopy) {
                                   [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"复制成功"];
                               }else{
                                   [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"分享成功"];
                               }
                           }
                               break;
                               
                           case SSDKResponseStateFail:
                               [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"分享失败"];
                           default:
                               break;
                       }
                   }];
        [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeCopy)];

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
