//
//  InvationRegisterView.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/10.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "InvationRegisterView.h"
#import "LewPopupViewController.h"

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
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
