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
#import "VoteDetailModel.h"
@interface VoteDetailView()<UITableViewDelegate,UITableViewDataSource>{
    VoteDetailModel * voteDetailModel;
    
    NSMutableArray * dataArr;
}


@property (nonatomic,strong)UITableView * tableView;
    
    
@end
@implementation VoteDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        dataArr = [NSMutableArray array];
        __weak typeof (self) weakSelf = self;
        [self requestAnswerListInfo:^(BOOL isSuccess) {
            [weakSelf configureView];
        }];
    }
    return self;
}

-(void)configureView{
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"VoteFirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"VoteFirstTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"VoteThirdTableViewCell" bundle:nil] forCellReuseIdentifier:@"VoteThirdTableViewCell"];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 200)];
        
        [imageView  sd_setImageWithURL:[NSURL URLWithString:voteDetailModel.Image] placeholderImage:[UIImage imageNamed:@"news_placeholder_Icon_1" ]options:SDWebImageRefreshCached];
        return cell;
        
    }else if (indexPath.section == 1){
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
//        UILabel * label =
        return cell;
        
    }else{
        VoteRowsModel * voteRowsM = dataArr[indexPath.row];
        if ([self.voteType intValue] == 1) {
            VoteFirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"VoteFirstTableViewCell" forIndexPath:indexPath];
            
            cell.voteRowsM = voteRowsM;
            return cell;
        }else if ([self.voteType intValue] == 1){
            VoteThirdTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"VoteThirdTableViewCell" forIndexPath:indexPath];
            
            cell.voteRowsM = voteRowsM;
            return cell;
        }
    }
    return nil;
}
#pragma mark - 网络请求

-(void)requestAnswerListInfo:(void(^)(BOOL isSuccess))finish{
    
    ActivityViewModel * activityVM = [[ActivityViewModel alloc]init];
    [activityVM setBlockWithReturnBlock:^(id returnValue) {
        voteDetailModel = returnValue;
        
        finish(YES);
    } WithFaileBlock:^{
        
    }];
    [activityVM fatchVoteDetailInfoID:self.voteID];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
