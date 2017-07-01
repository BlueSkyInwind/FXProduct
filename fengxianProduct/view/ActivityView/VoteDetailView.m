//
//  VoteDetailView.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/30.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "VoteDetailView.h"
#import "VoteFirstTableViewCell.h"
#import "VoteSecondCollectionViewCell.h"
#import "VoteThirdTableViewCell.h"
#import "ActivityViewModel.h"
#import <WebKit/WebKit.h>

@interface VoteDetailView()<UITableViewDelegate,UITableViewDataSource,WKNavigationDelegate>{
    
    NSMutableArray * dataArr;
    float IntroductionHeight;
    
    NSMutableArray * voteChooseArr;

}


@property (nonatomic,strong)UITableView * tableView;

@end
@implementation VoteDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
        voteChooseArr = [NSMutableArray array];
    }
    return self;
}

-(void)setVoteDetailModel:(VoteDetailModel *)voteDetailModel{
    _voteDetailModel = voteDetailModel;
    IntroductionHeight = [Tool heightForText:_voteDetailModel.Introduction width:_k_w font:15] + 15;
    dataArr = [_voteDetailModel.rows mutableCopy];
    [self.tableView reloadData];
}

-(void)configureView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];

    
    [self.tableView registerNib:[UINib nibWithNibName:@"VoteFirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"VoteFirstTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"VoteThirdTableViewCell" bundle:nil] forCellReuseIdentifier:@"VoteThirdTableViewCell"];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return _k_w * 4 / 7;
    }else if (indexPath.section == 1){
        return IntroductionHeight;
    }else if (indexPath.section == 2){
        return 90;
    }else{
        return 90;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return dataArr.count;
    }else{
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_w * 4 / 7)];
        [imageView  sd_setImageWithURL:[NSURL URLWithString:_voteDetailModel.Image] placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_1" ]options:SDWebImageRefreshCached];
        [cell.contentView addSubview:imageView];
        return cell;
    }else if (indexPath.section == 1){
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
         UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, _k_w, IntroductionHeight)];
        webView.userInteractionEnabled = NO;
        [webView loadHTMLString:_voteDetailModel.Introduction baseURL:nil];
        [cell.contentView addSubview:webView];
        return cell;
    }else if (indexPath.section == 2){
        VoteRowsModel * voteRowsM = dataArr[indexPath.row];
        if ([self.voteDetailModel.Type intValue] == 1) {
            VoteFirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"VoteFirstTableViewCell" forIndexPath:indexPath];
            cell.number = indexPath.row + 1;
            cell.voteNum =  _voteDetailModel.VoteNum;
            cell.voteRowsM = voteRowsM;
            cell.votechoose = ^(BOOL isSelected) {
                if (isSelected) {
                    
                    [voteChooseArr addObject:voteRowsM.ID];
                }else{
                    [voteChooseArr removeObject:voteRowsM.ID];
                }
            };
            return cell;
        }else if ([self.voteDetailModel.Type intValue] == 3){
            VoteThirdTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"VoteThirdTableViewCell" forIndexPath:indexPath];
            cell.voteNumber =  _voteDetailModel.VoteNum;
            cell.voteRowsM = voteRowsM;
            cell.votechoose = ^(BOOL isSelected) {
                if (isSelected) {
                    
                    [voteChooseArr addObject:voteRowsM.ID];
                }else{
                    [voteChooseArr removeObject:voteRowsM.ID];
                }
            };
            return cell;
        }
   
    } else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        }
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        UIButton * applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [applyButton setTitle:@"投 票" forState:UIControlStateNormal];
        [applyButton setTintColor:[UIColor whiteColor]];
        [applyButton setBackgroundColor:UI_MAIN_COLOR];
        applyButton.layer.cornerRadius = 8;
        applyButton.layer.masksToBounds = YES;
        [applyButton addTarget:self action:@selector(applyButtonCilck:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:applyButton];
        [applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.mas_centerY);
            make.left.equalTo(cell.mas_left).with.offset(_k_w / 3);
            make.right.equalTo(cell.mas_right).with.offset(_k_w /  (-3));
            make.height.equalTo(@45);
        }];
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 1;
    }
    return 0;
}


-(void)applyButtonCilck:(id)sender{
    
    ActivityViewModel * activityVM = [[ActivityViewModel alloc]init];
    [activityVM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode integerValue] == 1) {
            if (self.requestVoteStatus) {
                self.requestVoteStatus(YES);
            }
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self message:(NSString *)returnMsg.msg];
            if (self.requestVoteStatus) {
                self.requestVoteStatus(NO);
            }
        }
    } WithFaileBlock:^{
        
    }];
    if (voteChooseArr.count == 0) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self message:@"请选择投票！"];
        return;
    }
    NSString * conStr = voteChooseArr.firstObject;
    for (int i = 1; i < voteChooseArr.count; i++) {
        NSString * ID = voteChooseArr[i];
        [conStr stringByAppendingFormat:@",%@",ID];
    }
        
    [activityVM requestAddVote:conStr];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
