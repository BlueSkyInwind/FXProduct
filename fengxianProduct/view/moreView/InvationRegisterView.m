//
//  InvationRegisterView.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/10.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "InvationRegisterView.h"
#import "LewPopupViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
@interface InvationRegisterView(){
}


@property (nonatomic ,strong)UserQrcodeShareView * userQrcodeShareView;
@property (nonatomic,strong)UIViewController * superVC;

@end

@implementation InvationRegisterView

+(void)showInvationView:(UIViewController *)viewController{
    InvationRegisterView * invationRV = [[InvationRegisterView alloc]initWithFrame:CGRectMake(0, 0, viewController.view.frame.size.width, viewController.view.frame.size.height)];
    invationRV.superVC = viewController;
    [viewController.view addSubview:invationRV];
    [viewController lew_presentPopupView:invationRV animation:[LewPopupViewAnimationSpring new] backgroundClickable:NO dismissed:^{
        
    }];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kUIColorFromRGB(0x5e5e5e);
        self.alpha = 0.4;
        [self showQRCodeShareView];
    }
    return self;
}
-(void)showQRCodeShareView{
    
    self.userQrcodeShareView = [[NSBundle mainBundle]loadNibNamed:@"UserQrcodeShareView" owner:self options:nil].lastObject;
    self.userQrcodeShareView.delegate = self;
    [self addSubview:self.userQrcodeShareView];
    [self.userQrcodeShareView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(15);
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.top.equalTo(self.mas_top).with.offset(30);
        make.bottom.equalTo(self.mas_bottom).with.offset(-30);
    }];
    
}
-(void)closeViewClick{
    
    [self.superVC lew_dismissPopupViewWithanimation:[LewPopupViewAnimationSpring new]];

}
-(void)invationCodeClick{
    
    [self shareContent:_AppDownload_url Title:@"下载“IN奉贤”"];
}

//分享函数
-(void)shareContent:(NSString*)urlStr Title:(NSString *)title
{
 
    NSArray *imageArr = @[self.userQrcodeShareView.qrCodeImage.image];
    NSString * str = [NSString stringWithFormat:@"安装注册输入邀请码：%@",self.userQrcodeShareView.invationCodeLabel.text];
    if (imageArr) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:str
                                         images:imageArr
                                            url:[NSURL URLWithString:urlStr]
                                          title:title
                                           type:SSDKContentTypeAuto];
        [shareParams SSDKEnableUseClientShare];
     SSUIShareActionSheetController * sheet  =   [ShareSDK showShareActionSheet:nil
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess:{
                               if (platformType == SSDKPlatformTypeCopy) {
                                   [[MBPAlertView sharedMBPTextView] showTextOnly:self message:@"复制成功"];
                               }else{
                                   [[MBPAlertView sharedMBPTextView] showTextOnly:self message:@"分享成功"];
                               }
                           }
                               break;
                               
                           case SSDKResponseStateFail:
                               [[MBPAlertView sharedMBPTextView] showTextOnly:self.superVC.view message:@"分享失败"];
                           default:
                               break;
                       }
                   }];
        [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeCopy)];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
