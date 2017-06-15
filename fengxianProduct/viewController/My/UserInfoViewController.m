//
//  UserInfoViewController.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/8.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoTableViewCell.h"
#import "LoginViewController.h"
#import "PickerSelectView.h"
#import "MoreViewModel.h"
#import "InvationRegisterView.h"
@interface UserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,PickerselectViewDelegate>{
    
    NSArray * titleArr;
    NSMutableArray * contentArr;
    
    NSString * userImageUrl;
    NSString * userAccount;
    NSString * nickname;
    NSString * userID;
    NSString * userQrcode;
    NSString * mohliePhone;
    NSString * emailStr;
    NSString * gender;
    NSString * birthday;
    NSString * userLocation;
    
    PickerViewType PVType;
    UIView * maskView;

    NSData * seletedImageData;

}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UserInfoTableViewCell * userInfoTableViewCell;
@property (nonatomic,strong)PickerSelectView * picSV;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人信息";
    [self addBackItem];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveUserInfo)];
    barBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = barBtn;
    
    [self initializeUserData];
    [self configureView];
}

-(void)initializeUserData{
    
    titleArr = @[@[@"头像",@"账号",@"昵称",@"ID",@"我的二维码名片"],@[@"手机",@"邮箱"],@[@"性别",@"出生日期",@"地址"]];
    userImageUrl = [Utility sharedUtility].userInfo.Images == nil ? @"" : [Utility sharedUtility].userInfo.Images;
    userAccount = [Utility sharedUtility].userInfo.Mobile == nil ? @"" : [Utility sharedUtility].userInfo.Mobile;
    nickname = [Utility sharedUtility].userInfo.Name == nil ? @"" : [Utility sharedUtility].userInfo.Name;
    userID = [Utility sharedUtility].userInfo.Code == nil ? @"" : [Utility sharedUtility].userInfo.Code;
    userQrcode = @"More_userQRCode_Icon_gray";
    mohliePhone = [Utility sharedUtility].userInfo.Mobile == nil ? @"" : [Utility sharedUtility].userInfo.Mobile;
    emailStr = [Utility sharedUtility].userInfo.Email == nil ? @"" : [Utility sharedUtility].userInfo.Email;
    gender = [[Utility sharedUtility].userInfo.Gender intValue] == 1 ?  @"男":@"女";
    birthday = [Utility sharedUtility].userInfo.Date == nil ? @"" : [Utility sharedUtility].userInfo.Date;
    userLocation = [Utility sharedUtility].userInfo.Address == nil ? @"" : [Utility sharedUtility].userInfo.Address;
    
    NSMutableArray * arr1 = [NSMutableArray arrayWithArray:@[userImageUrl,userAccount,nickname,userID,userQrcode]];
    NSMutableArray * arr2 = [NSMutableArray arrayWithArray:@[mohliePhone,emailStr]];
    NSMutableArray * arr3 = [NSMutableArray arrayWithArray:@[gender,birthday,userLocation]];

    contentArr = [NSMutableArray arrayWithObjects:arr1,arr2,arr3, nil];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}
-(void)configureView{
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kUIColorFromRGB(0xe5e5e5);
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    [self.tableView registerNib:[UINib nibWithNibName:@"UserInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"UserInfoTableViewCell"];
}
#pragma  mrak - 点击事件
-(void)saveUserInfo{
    
    MoreViewModel * moreVM = [[MoreViewModel alloc]init];
    [moreVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"保存成功"];
            [[ShareConfig share]updateUserData];
        }
    } WithFaileBlock:^{
        
    }];
    gender = contentArr[2][0];
    NSString * num = @"";
    if ([gender isEqualToString:@"男"]) {
        num = @"1";
    }else if([gender isEqualToString:@"女"]){
        num = @"0";
    }
    [moreVM updateAccountInfo:contentArr[0][2] gender:num email:contentArr[1][1] moblie:contentArr[1][0]  date:contentArr[2][1]  address:contentArr[2][2] image:contentArr[0][0]];
}
-(void)uploadAvatar:(NSDictionary *)data  finsh:(void(^)(bool isSuccess))finsh{
    
    MoreViewModel * moreVM = [[MoreViewModel alloc]init];
    [moreVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            [contentArr[0] replaceObjectAtIndex:0 withObject:returnMsg.Url];
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"头像上传成功"];
            finsh(YES);
        }
    } WithFaileBlock:^{
        
    }];
    [moreVM uploadAvatarImage:data];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_IS_IPHONE6P) {
        return 70;
    }else{
        return 60;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section > titleArr.count - 1) {
        return 1;
    }else{
        return [titleArr[section] count];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return titleArr.count + 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == contentArr.count) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LoginOutCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LoginOutCell"];
        }
        cell.backgroundColor = kUIColorFromRGB(0xe5e5e5);
        UIButton * loginOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginOutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [loginOutButton setTintColor:[UIColor whiteColor]];
        [loginOutButton setBackgroundColor:UI_MAIN_COLOR];
        loginOutButton.layer.cornerRadius = 8;
        loginOutButton.layer.masksToBounds = YES;
        [loginOutButton addTarget:self action:@selector(loginOutButtonCilck:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:loginOutButton];
        [loginOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.mas_centerY);
            make.left.equalTo(cell.mas_left).with.offset(_k_w / 3);
            make.right.equalTo(cell.mas_right).with.offset(_k_w /  (-3));
            make.height.equalTo(@45);
        }];
        return cell;
    }
    
    UserInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoTableViewCell"];
    if (!cell) {
        cell = [[UserInfoTableViewCell alloc]init];
    }
    cell.titleLabel.text = titleArr[indexPath.section][indexPath.row];
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row == 0) {
                cell.contentImageView.hidden = NO;
                [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:contentArr[indexPath.section][indexPath.row]] placeholderImage:[UIImage imageNamed:@"user_Icon"] options:SDWebImageRefreshCached];
            }else if (indexPath.row == 4){
                cell.contentImageView.hidden = NO;
                cell.contentImageView.image = [UIImage imageNamed:contentArr[indexPath.section][indexPath.row]];
            }else{
                cell.contentLabel.text = contentArr[indexPath.section][indexPath.row];
            }
        }
            break;
        case 1:{
            cell.contentLabel.text = contentArr[indexPath.section][indexPath.row];
        }
            break;
        case 2:{
            cell.contentLabel.text = contentArr[indexPath.section][indexPath.row];
        }
            break;
   
        default:
            break;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    [[CameraHelper shareManager]obtainController:self userSeletedImage:^(UIImage *userImage, NSData *userImageData, NSString * userimageName) {
                        [self uploadAvatar:@{userimageName : userImageData} finsh:^(bool isSuccess) {
                            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        }];
                    }];
                }
                    break;
                case 2:{
                    [[ShareConfig share]presentAlertTextfield:self placeHolder:@"请输入昵称" userInputContent:^(NSString *resultStr) {
                        if (resultStr != nil && ![resultStr isEqualToString:@""]) {
                            [contentArr[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:resultStr];
                            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        }
                        
                    }];
                }
                    break;
                case 4:{
                    [self popInavationView];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:{
            if (indexPath.row == 0) {
                
                [[ShareConfig share]presentAlertTextfield:self placeHolder:@"请输入手机号" userInputContent:^(NSString *resultStr) {
                    if ([Tool isMobileNumber:resultStr]) {
                         [contentArr[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:resultStr];
                        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                    }else{
                        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"手机号码格式不正确"];
                    }
                }];
            }else if(indexPath.row == 1){
                [[ShareConfig share]presentAlertTextfield:self placeHolder:@"请输入邮箱" userInputContent:^(NSString *resultStr) {
                    if (resultStr != nil && ![resultStr isEqualToString:@""]) {
                        [contentArr[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:resultStr];
                        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                    }
                }];
            }
            
        }
            break;
        case 2:{
            if (indexPath.row == 0) {
                [self showPickerViewType:genderPickerView];
                PVType = genderPickerView;
                
            }else if (indexPath.row == 1){
                [self showPickerViewType:birPickerView];
                PVType = birPickerView;

            }else{
                [[ShareConfig share]presentAlertTextfield:self placeHolder:@"请输入地址" userInputContent:^(NSString *resultStr) {
                    if (resultStr != nil && ![resultStr isEqualToString:@""]) {
                        [contentArr[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:resultStr];
                        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                    }
                }];
            }
        }
            break;
        default:
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 ) {
        return 0;
    }else if (section == 3){
        return 1;
    }else{
        return 20;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = kUIColorFromRGB(0xe5e5e5);
    return view;
}
-(void)loginOutButtonCilck:(id)sender{
    
    LoginViewController *loginView = [[LoginViewController alloc]init];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginView];
    [self presentViewController:nav animated:YES completion:^{
        [EmptyUserData EmptyData];
    }];
}
-(void)popInavationView{
    
    [InvationRegisterView showInvationView:self];
    
}

#pragma mark ------ PickerselectViewDelegate------
-(void)clickCancelButton{
    
    [self removePickerView];
    
}
-(void)clicksureButton:(NSString *)context{
    switch (PVType) {
        case 0:{
            [contentArr[2] replaceObjectAtIndex:0 withObject:context];
        }
            break;
        case 1:{
            [contentArr[2] replaceObjectAtIndex:1 withObject:context];
        }
            break;
            
        default:
            break;
    }
    [self removePickerView];
    [self.tableView reloadData];
}
#pragma mark ----------PickerSelectView弹出动画-----------
-(void)showPickerViewType:(PickerViewType)pickerViewType{
    
    if (self.picSV != nil) {
        return;
    }
    maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.5;
    self.picSV = [[[NSBundle mainBundle]loadNibNamed:@"PickerSelectView" owner:nil options:nil]firstObject];
    self.picSV.frame = CGRectMake(0, _k_h + 200, _k_w, 202);
    [self.picSV configureView:self.view pickerViewType:pickerViewType delegate:self];
    
    [[UIApplication sharedApplication].keyWindow addSubview:maskView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.picSV];
    self.tableView.scrollEnabled = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.picSV.frame = CGRectMake(0, _k_h - 202, _k_w, 202);
        
    } completion:^(BOOL finished) {
        
        
    }];
}
-(void)removePickerView{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.picSV.frame = CGRectMake(0, _k_h + 200, _k_w, 202);
        
    } completion:^(BOOL finished) {
        
    }];
    self.tableView.scrollEnabled = YES;
    [maskView removeFromSuperview];
    [ self.picSV removeFromSuperview];
    self.picSV = nil;
    
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
