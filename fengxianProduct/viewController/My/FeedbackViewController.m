//
//  FeedbackViewController.m
//  fengxianProduct
//
//  Created by admin on 2017/6/15.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "FeedbackViewController.h"
#import "MoreViewModel.h"
#import "FeedbackViewModel.h"
#import "MyFeedbackViewController.h"

@interface FeedbackViewController (){
    NSString * uploadimageURL;
}

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"使用反馈";
    self.automaticallyAdjustsScrollViewInsets = NO;
    uploadimageURL = @"";
    [self addBackItem];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithTitle:@"我的反馈" style:UIBarButtonItemStylePlain target:self action:@selector(saveUserInfo)];
    barBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = barBtn;
    [Tool setCorner:self.submitBtn borderColor:UI_MAIN_COLOR];

}
-(void)saveUserInfo{
    MyFeedbackViewController * myFeedbackVC = [[MyFeedbackViewController alloc]init];
    [self.navigationController pushViewController:myFeedbackVC animated:YES];
    
}
- (IBAction)submitBtnCilck:(id)sender {
    FeedbackViewModel * feedbackVM = [[FeedbackViewModel alloc]init];
    [feedbackVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } WithFaileBlock:^{
        
    }];
   NSString * str = [self.contentTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([str isEqualToString:@""]) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入反馈内容"];
    }
    [feedbackVM uploadAccountFeedfackInfo:self.contentTextView.text imageURl:uploadimageURL userNumber:self.contactWayTextField.text];
}
- (IBAction)selectImageBtnCilck:(id)sender {
    [[CameraHelper shareManager]obtainController:self isVedio:NO userSeletedImage:^(UIImage *userImage, NSData *userImageData, NSString * userimageName) {
        [self uploadAvatar:@{userimageName : userImageData} finsh:^(bool isSuccess) {
            
        }];
    }];
}
-(void)uploadAvatar:(NSDictionary *)data  finsh:(void(^)(bool isSuccess))finsh{
    
    MoreViewModel * moreVM = [[MoreViewModel alloc]init];
    [moreVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            uploadimageURL = returnMsg.Url;
            self.imageBtn.userInteractionEnabled = NO;
            [self.imageBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [self.imageBtn sd_setImageWithURL:[NSURL URLWithString:returnMsg.Url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"feedback_image_Icon"] options:SDWebImageRefreshCached];
//            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"上传成功"];
            finsh(YES);
        }
    } WithFaileBlock:^{
        
    }];
    [moreVM uploadAvatarImage:data];
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
