//
//  ActivityBrokeViewTableViewCell.m
//  fengxianProduct
//
//  Created by admin on 2017/6/15.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ActivityBrokeViewTableViewCell.h"
#import "MoreViewModel.h"
#import "ActivityViewModel.h"
@interface ActivityBrokeViewTableViewCell()<WriteInfoViewDelegate>{
    
    NSString * vedioUrl;
    NSString * imageUrl;
    NSString * typeStr;

}
@end

@implementation ActivityBrokeViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [Tool setCornerWithoutRadius:self.backView borderColor:[UIColor grayColor]];
    self.updateList.layer.cornerRadius = self.updateList.frame.size.width;
    self.updateList.clipsToBounds = YES;
    self.updateList.hidden = YES;
    
    self.baoliaoBtn.layer.cornerRadius = 3;
    self.baoliaoBtn.clipsToBounds = YES;
    self.contributeBtn.layer.cornerRadius = 3;
    self.contributeBtn.clipsToBounds = YES;
    
    isBaoliao = NO;
    isContribute = NO;
}

-(void)setColumnInfoM:(ColumnInfoModel *)columnInfoM{
    _columnInfoM = columnInfoM;
    self.titleLabel.text = columnInfoM.Title;
}

- (IBAction)baoliaoBtnClick:(id)sender {
    if ([[ShareConfig share] isPresentLoginVC:self.vc]) {
        isBaoliao = !isBaoliao;
        if (isContribute) {
            isContribute = !isContribute;
            [self.contributeBtn setBackgroundColor:kUIColorFromRGB(0x5e5e5e)];
        }
        if (isBaoliao) {
            [self.baoliaoBtn setBackgroundColor:UI_MAIN_COLOR];
            [self loadWriteInfoView:1];
        }else{
            [self.baoliaoBtn setBackgroundColor:kUIColorFromRGB(0x5e5e5e)];
            [self removeWriteInfoView];
        }
    }

}
- (IBAction)contributeBtnClick:(id)sender {
  
    if ([[ShareConfig share] isPresentLoginVC:self.vc]) {
        isContribute = !isContribute;
        if (isBaoliao) {
            isBaoliao = !isBaoliao;
            [self.baoliaoBtn setBackgroundColor:kUIColorFromRGB(0x5e5e5e)];
        }
        if (isContribute) {
            [self.contributeBtn setBackgroundColor:UI_MAIN_COLOR];
            [self loadWriteInfoView:2];
        }else{
            [self.contributeBtn setBackgroundColor:kUIColorFromRGB(0x5e5e5e)];
            [self removeWriteInfoView];
        }
    }
}

/**
 加载信息填写页面

 @param type 1，爆料  2，投稿
 */
-(void)loadWriteInfoView:(NSInteger)type{
    
    if (self.writeInfoView) {
        if (type == 1) {
            self.writeInfoView.contributeView.hidden= YES;
            self.writeInfoView.contributeType = 1;
            [self.writeInfoView removeImageDisplaySubView];
            [self.writeInfoView initAddImageView];
        }else{
            self.writeInfoView.contributeView.hidden= NO;
        }
        return;
    }
    self.writeInfoView = [[NSBundle mainBundle]loadNibNamed:@"WriteInfoView" owner:self options:nil].lastObject;
    self.writeInfoView.backgroundColor = [UIColor whiteColor];
    self.writeInfoView.delegate =self;
    [self.backView addSubview:self.writeInfoView];
    [self.writeInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
    }];
    __weak typeof (self) weakSelf = self;
    self.writeInfoView.writeInfoViewHeight = ^(float height) {
        if (weakSelf.activityBrokeViewTableViewHeight) {
            weakSelf.activityBrokeViewTableViewHeight(620 + height);
        }
    };
    self.writeInfoView.Type = ^(NSInteger type) {
        typeStr = [NSString stringWithFormat:@"%ld",(long)type];
    };
    
    if (type == 1) {
        self.writeInfoView.contributeView.hidden= YES;
    }else{
        self.writeInfoView.contributeView.hidden= NO;
    }
    
    if (self.activityBrokeViewTableViewHeight) {
        self.activityBrokeViewTableViewHeight(620);
    }
}
-(void)removeWriteInfoView{
    
    [self.writeInfoView removeFromSuperview];
    self.writeInfoView = nil;
    if (self.activityBrokeViewTableViewHeight) {
        self.activityBrokeViewTableViewHeight(260);
    }
}
#pragma mrak - WriteInfoViewDelegate
-(void)submitButtonClick{
    ActivityViewModel * activityVM = [[ActivityViewModel alloc]init];
    [activityVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            [[NSFileManager defaultManager] removeItemAtPath:saveIamgeUrlPath error:nil];
            [[NSFileManager defaultManager] removeItemAtPath:saveIamgePath error:nil];
            [self.contributeBtn setBackgroundColor:kUIColorFromRGB(0x5e5e5e)];
            [self.baoliaoBtn setBackgroundColor:kUIColorFromRGB(0x5e5e5e)];
            [self removeWriteInfoView];
        }
    } WithFaileBlock:^{
        
    }];
    if (isBaoliao) {
        typeStr = @"0";
    }
    imageUrl = @"";
    NSMutableArray * array = [[NSArray arrayWithContentsOfFile:saveIamgeUrlPath] mutableCopy];
    if (array) {
        for (NSString * str in array) {
            imageUrl = [imageUrl stringByAppendingFormat:@"%@:;",str];
        }
    }
    
    [activityVM uploadUserWriteInfo:self.writeInfoView.titleTextField.text content:self.writeInfoView.contentTextView.text type:typeStr imageStr:imageUrl MP4:vedioUrl];
}
-(void)submitImageClick{
    __weak typeof (self) weakSelf = self;
    [[CameraHelper shareManager]obtainController:self.vc isVedio:NO userSeletedImage:^(UIImage *userImage, NSData *userImageData, NSString * userimageName) {
        [self uploadAvatar:@{userimageName : userImageData} finsh:^(bool isSuccess,NSString * contentUrlStr) {
            [weakSelf saveIamgeUrl:contentUrlStr];
            [weakSelf.writeInfoView addUploadImageView:userImageData];
        }];
    }];
}
-(void)saveIamgeUrl:(NSString *)imageUrlStr{
    
    NSMutableArray * array = [[NSArray arrayWithContentsOfFile:saveIamgeUrlPath] mutableCopy];
    if (!array) {
        array = [NSMutableArray array];
    }
    [array addObject:imageUrlStr];
    [array writeToFile:saveIamgeUrlPath atomically:YES];
}

-(void)submitVedioClick{
    __weak typeof (self) weakSelf = self;
    [[CameraHelper shareManager]obtainController:self.vc isVedio:YES userSeletedImage:^(UIImage *userImage, NSData *userImageData, NSString * userimageName) {
        [self uploadAvatar:@{userimageName : userImageData} finsh:^(bool isSuccess,NSString * contentUrlStr) {
            vedioUrl = contentUrlStr;
            [weakSelf.writeInfoView.vedioClickBtn setBackgroundImage:userImage forState:UIControlStateNormal];
        }];
    }];
}

-(void)uploadAvatar:(NSDictionary *)data  finsh:(void(^)(bool isSuccess ,NSString * contentUrlStr))finsh{
    
    MoreViewModel * moreVM = [[MoreViewModel alloc]init];
    [moreVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            finsh(YES,returnMsg.Url);
        }
    } WithFaileBlock:^{
        
    }];
    [moreVM uploadAvatarImage:data];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
