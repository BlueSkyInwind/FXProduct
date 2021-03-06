//
//  MyCollectTableViewCell.m
//  fengxianProduct
//
//  Created by admin on 2017/6/22.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MyCollectTableViewCell.h"
#import "NewsTwoTableViewCell.h"
#import "NewsMultipleTableViewCell.h"
#import "NewsTableViewCell.h"
#import "PhotoViewController.h"
#import "DetailViewController.h"


@implementation MyCollectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectedDeleteBtn.hidden = YES;
    self.timeLabelLeftCons.constant = 10;
    [self configureView];
}

-(void)setNewsListInfo:(NewsListInfo *)newsListInfo{
    _newsListInfo = newsListInfo;
//    [self layoutIfNeeded];
    if ([_newsListInfo.CommType isEqualToString:@"8"]) {
        self.titleLabel.text = @"新闻";
    }
    isCanDelete = NO;
    self.timeLabel.text = _newsListInfo.Time;
    [self.contentTableView reloadData];
    if (_isDelete) {
        self.selectedDeleteBtn.hidden = NO;
        self.timeLabelLeftCons.constant = 30;
    }else{
        self.selectedDeleteBtn.hidden = YES;
        self.timeLabelLeftCons.constant = 10;
    }
    if (isCanDelete) {
        [self.selectedDeleteBtn setBackgroundImage:[UIImage imageNamed:@"collect_Seleted_Delete"] forState:UIControlStateNormal];
    }else{
        [self.selectedDeleteBtn setBackgroundImage:[UIImage imageNamed:@"collect_unseleted_Delete"] forState:UIControlStateNormal];
    }
}

- (IBAction)seletedDeleteBtnClick:(id)sender {
    isCanDelete = !isCanDelete;
    if (isCanDelete) {
        [self.selectedDeleteBtn setBackgroundImage:[UIImage imageNamed:@"collect_Seleted_Delete"] forState:UIControlStateNormal];
    }else{
        [self.selectedDeleteBtn setBackgroundImage:[UIImage imageNamed:@"collect_unseleted_Delete"] forState:UIControlStateNormal];
    }
    UIButton * button = (UIButton *)sender;
    if (self.selectedBtn) {
        self.selectedBtn(button.tag,isCanDelete);
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];

}
-(void)configureView{
    
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    self.contentTableView.backgroundColor = [UIColor whiteColor];
    self.contentTableView.scrollEnabled = NO;
    self.contentTableView.userInteractionEnabled = NO;
    //    self.contentTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    
    [self.contentTableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTableViewCell"];
    [self.contentTableView registerNib:[UINib nibWithNibName:@"NewsTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTwoTableViewCell"];
    [self.contentTableView registerNib:[UINib nibWithNibName:@"NewsMultipleTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsMultipleTableViewCell"];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_newsListInfo.Seat intValue] == 1) {
        return 140;
    }else if ([_newsListInfo.Seat intValue] == 4){
        return 140;
    }
    return 90;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_newsListInfo == nil) {
        return 0;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_newsListInfo.Seat intValue] == 1) {
        NewsMultipleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsMultipleTableViewCell" forIndexPath:indexPath];
        cell.backgroundColor = kUIColorFromRGB(0xF5F5F5);
        cell.newsList = _newsListInfo;
        return cell;
        
    }else if ([_newsListInfo.Seat intValue] == 4){
        
        NewsTwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsTwoTableViewCell" forIndexPath:indexPath];
        cell.backgroundColor = kUIColorFromRGB(0xF5F5F5);
        cell.newsList = _newsListInfo;
        return cell;
        
    }
    
    NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"NewsTableViewCell"];
    }
    cell.backgroundColor = kUIColorFromRGB(0xF5F5F5);
    cell.newsList = _newsListInfo;
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
