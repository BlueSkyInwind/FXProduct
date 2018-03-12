//
//  AnswerDetailView.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/7/1.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "AnswerDetailView.h"
#import "GapFillingTableViewCell.h"
#import "SingleChooseTableViewCell.h"
#import "MultipleChooseTableViewCell.h"
#import "ActivityViewModel.h"
#import <WebKit/WebKit.h>

@interface AnswerDetailView()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray * dataArr;
    float IntroductionHeight;
    
}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * resultArr;
//@property (nonatomic,strong)NSMutableArray * multipleArr;


@end
@implementation AnswerDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
      
    }
    return self;
}
-(void)setAnswerDetailModel:(AnswerDetailModel *)answerDetailModel{
    
    _answerDetailModel = answerDetailModel;
    IntroductionHeight = [Tool heightForText:_answerDetailModel.Title width:_k_w font:15] + 15;
    dataArr = [_answerDetailModel.rows mutableCopy];
    NSString * str = @" ";
    _resultArr = [NSMutableArray array];
    for (int i = 0; i < self.answerDetailModel.rows.count; i ++) {
        [_resultArr addObject:str];
    }
//    _multipleArr = [NSMutableArray array];
    [self.tableView reloadData];
}

-(void)configureView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GapFillingTableViewCell" bundle:nil] forCellReuseIdentifier:@"GapFillingTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SingleChooseTableViewCell" bundle:nil] forCellReuseIdentifier:@"SingleChooseTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MultipleChooseTableViewCell" bundle:nil] forCellReuseIdentifier:@"MultipleChooseTableViewCell"];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return _k_w * 4 / 7;
    }else if (indexPath.section == 1){
        return IntroductionHeight;
    }else if (indexPath.section == 2){
        float height = 150;
        AnswerRowsModel * model = dataArr[indexPath.row];
        if ([model.States intValue] == 2 || [model.States intValue] == 3) {
            NSString * str = model.Review;
            NSArray * contentArr = [[str componentsSeparatedByString:@":"] mutableCopy];
            height = 0;
            for (NSString * str1 in contentArr) {
                float numHeight = [Tool heightForText:str1 width:_k_w - 50 font:14] + 10;
                height  = height + numHeight;
            }
        }
        return height + 30;
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
        [imageView  sd_setImageWithURL:[NSURL URLWithString:_answerDetailModel.ImageURL] placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_1" ]options:SDWebImageRefreshCached];
        [cell.contentView addSubview:imageView];
        return cell;
    }else if (indexPath.section == 1){
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, _k_w, IntroductionHeight)];
        webView.userInteractionEnabled = NO;
        [webView loadHTMLString:_answerDetailModel.Title baseURL:nil];
        [cell.contentView addSubview:webView];
        return cell;
    }else if (indexPath.section == 2){
        AnswerRowsModel * answerRowsM = dataArr[indexPath.row];
        if ([answerRowsM.States intValue] == 1) {
            GapFillingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GapFillingTableViewCell" forIndexPath:indexPath];
            cell.number = indexPath.row + 1;
            cell.answerRowsModel = answerRowsM;
            __weak typeof (self) weakSelf = self;
            cell.contentResultStr = ^(NSString *resultStr, NSInteger num) {
                [weakSelf.resultArr replaceObjectAtIndex:num - 1 withObject:resultStr];
            };
            return cell;
        }else if ([answerRowsM.States intValue] == 2){
            SingleChooseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SingleChooseTableViewCell" forIndexPath:indexPath];
            cell.number = indexPath.row + 1;
            cell.answerRowsModel = answerRowsM;

            __weak typeof (self) weakSelf = self;
            cell.singleChoose = ^(NSString *resultSTr, BOOL isDelete, NSInteger num) {
                if (isDelete) {
                    [weakSelf.resultArr removeObjectAtIndex:num];
                }else{
                    [weakSelf.resultArr replaceObjectAtIndex:num - 1 withObject:resultSTr];
                }
            };
            return cell;
        }else if ([answerRowsM.States intValue] == 3){
            MultipleChooseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MultipleChooseTableViewCell" forIndexPath:indexPath];
            cell.number = indexPath.row + 1;
            cell.answerRowsModel = answerRowsM;
            __weak typeof (self) weakSelf = self;
            cell.multipleChoose = ^(NSString *resultSTr, BOOL isDelete, NSInteger num) {
                NSMutableArray * multipleArr;
                id item = weakSelf.resultArr[num - 1];
                if ([item isKindOfClass:[NSMutableArray class]]) {
                    multipleArr = [item mutableCopy];
                }else{
                    multipleArr = [NSMutableArray array];
                }
                
                if (isDelete) {
                    [multipleArr removeObject:resultSTr];
                }else{
                    [multipleArr addObject:resultSTr];
                }
                [weakSelf.resultArr replaceObjectAtIndex:num - 1 withObject:multipleArr ];
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
        [applyButton setTitle:@"提 交" forState:UIControlStateNormal];
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
            if (self.requestAnswerStatus) {
                self.requestAnswerStatus(YES);
            }
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self message:(NSString *)returnMsg.msg];
            if (self.requestAnswerStatus) {
                self.requestAnswerStatus(NO);
            }
        }
    } WithFaileBlock:^{
        
    }];
    if (_resultArr.count == 0) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self message:@"请选择答题！"];
        return;
    }
    NSString * conStr;
    if ([_resultArr.firstObject isKindOfClass:[NSMutableArray class]]) {
        conStr = [_resultArr.firstObject componentsJoinedByString:@":"];
    }else{
        conStr = _resultArr.firstObject;
    }
    for (int i = 1; i < _resultArr.count; i++) {
        id item = _resultArr[i];
        if ([item isKindOfClass:[NSString class]]) {
           conStr = [conStr stringByAppendingFormat:@",%@",item];
        }else if ([item isKindOfClass:[NSMutableArray class]]){
            NSString *string = [item componentsJoinedByString:@":"];
           conStr = [conStr stringByAppendingFormat:@",%@",string];
        }
    }
    NSLog(@"%@",conStr);
    [activityVM frequestAddAnswerDEtailInfoID:self.answerID answerCon:conStr];
}

@end
